package com.frimastudio.fj_curriculumassociates_edu.ui.box
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.FontList;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Geometry;
	import com.frimastudio.fj_curriculumassociates_edu.util.StringUtil;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Box extends Sprite
	{
		protected var mSize:Rectangle;
		protected var mDefaultSize:Rectangle;
		protected var mColor:int;
		protected var mContentTemplate:BoxContent;
		protected var mPointDirection:Direction;
		protected var mAutoSizeAxis:Axis;
		protected var mGraphic:Sprite;
		protected var mPoint:Sprite;
		protected var mContent:Sprite;
		protected var mMargin:Number;
		protected var mGraphicBounds:Rectangle;
		
		public function get Size():Point	{ return mSize.size; }
		public function set Size(aValue:Point):void
		{
			var sizeWidth:Number = Math.max(aValue.x, mMargin * 2);
			var sizeHeight:Number = Math.max(aValue.y, mMargin * 2);
			switch (mAutoSizeAxis)
			{
				case Axis.HORIZONTAL:
					sizeWidth = mContent.width + (mMargin * 2);
					break;
				case Axis.VERTICAL:
					sizeHeight = mContent.height + (mMargin * 2);
					break;
				case Axis.BOTH:
					sizeWidth = mContent.width + (mMargin * 2);
					sizeHeight = mContent.height + (mMargin * 2);
					break;
				default:
					break;
			}
			mSize = new Rectangle(-sizeWidth / 2, -sizeHeight / 2, sizeWidth, sizeHeight);
			
			DrawBox();
			DrawPoint();
		}
		
		public function get BoxColor():int	{ return mColor; }
		public function set BoxColor(aValue:int):void
		{
			mColor = aValue;
			
			DrawBox();
			DrawPoint();
		}
		
		public function get Content():BoxContent	{ return mContentTemplate; }
		public function set Content(aValue:BoxContent):void
		{
			mContentTemplate = (aValue ? aValue : new BoxLabel());
			
			DrawContent();
		}
		
		public function get PointDirection():Direction	{ return mPointDirection; }
		public function set PointDirection(aValue:Direction):void
		{
			mPointDirection = aValue;
			
			DrawPoint();
		}
		
		public function get AutoSizeAxis():Axis	{ return mAutoSizeAxis; }
		public function set AutoSizeAxis(aValue:Axis):void
		{
			mAutoSizeAxis = aValue;
		}
		
		public function get Label():String
		{
			if (!(mContentTemplate is BoxLabel))
			{
				throw new Error("This box does not have a BoxLabel content.");
				return null;
			}
			
			return (mContentTemplate as BoxLabel).Label;
		}
		public function set Label(aValue:String):void
		{
			if (!(mContentTemplate is BoxLabel))
			{
				throw new Error("This box does not have a BoxLabel content.");
				return;
			}
			
			(mContentTemplate as BoxLabel).Label = aValue;
			DrawContent();
		}
		
		public function Box(aSize:Point, aColor:int = -1, aContent:BoxContent = null, aMargin:Number = 0,
			aPointDirection:Direction = null, aAutoSizeAxis:Axis = null)
		{
			super();
			
			mSize = new Rectangle(-aSize.x / 2, -aSize.y / 2, aSize.x, aSize.y);
			mDefaultSize = mSize.clone();
			mColor = (aColor == -1 ? Palette.GENERIC_BTN : aColor);
			mContentTemplate = (aContent ? aContent : new BoxLabel());
			mPointDirection = aPointDirection;
			mAutoSizeAxis = (aAutoSizeAxis ? aAutoSizeAxis : Axis.NONE);
			
			mGraphic = new Sprite();
			addChild(mGraphic);
			
			mPoint = new Sprite();
			addChild(mPoint);
			
			mContent = new Sprite();
			addChild(mContent);
			
			mMargin = aMargin;
			
			DrawBox();
			DrawPoint();
			DrawContent();
			
			Content = mContentTemplate;
		}
		
		protected function DrawBox():void
		{
			mGraphic.graphics.clear();
			
			mGraphic.graphics.lineStyle();
			mGraphic.graphics.beginFill(mColor);
			mGraphic.graphics.moveTo(mSize.left, mSize.top);
			mGraphic.graphics.lineTo(mSize.right, mSize.top);
			mGraphic.graphics.lineTo(mSize.right, mSize.bottom);
			mGraphic.graphics.lineTo(mSize.left, mSize.bottom);
			mGraphic.graphics.lineTo(mSize.left, mSize.top);
			mGraphic.graphics.endFill();
		}
		
		protected function DrawPoint():void
		{
			mPoint.graphics.clear();
			
			var coordinateList:Vector.<Point> = new Vector.<Point>();
			switch (mPointDirection)
			{
				case Direction.UP:
					coordinateList.push(new Point(13, mSize.top + 5));
					coordinateList.push(new Point(0, mSize.top - 20));
					coordinateList.push(new Point(0, mSize.top + 5));
					break;
				case Direction.RIGHT:
					coordinateList.push(new Point(mSize.right - 5, -13));
					coordinateList.push(new Point(mSize.right + 20, 0));
					coordinateList.push(new Point(mSize.right - 5, 0));
					break;
				case Direction.DOWN:
					coordinateList.push(new Point(-23, mSize.bottom - 5));
					coordinateList.push(new Point(0, mSize.bottom + 40));
					coordinateList.push(new Point(0, mSize.bottom - 5));
					break;
				case Direction.LEFT:
					coordinateList.push(new Point(mSize.left + 5, -13));
					coordinateList.push(new Point(mSize.left - 20, 0));
					coordinateList.push(new Point(mSize.left + 5, 0));
					break;
				case Direction.UP_LEFT:
					coordinateList.push(new Point(mSize.left + 27, mSize.top + 5));
					coordinateList.push(new Point(mSize.left + 40, mSize.top - 20));
					coordinateList.push(new Point(mSize.left + 40, mSize.top + 5));
					break;
				case Direction.DOWN_LEFT:
					coordinateList.push(new Point(mSize.left + 17, mSize.bottom - 5));
					coordinateList.push(new Point(mSize.left + 40, mSize.bottom + 40));
					coordinateList.push(new Point(mSize.left + 40, mSize.bottom - 5));
					break;
				default:
					return;
			}
			
			mPoint.graphics.lineStyle();
			mPoint.graphics.beginFill(mColor);
			mPoint.graphics.moveTo(coordinateList[0].x, coordinateList[0].y);
			for (var i:int = 1, endi:int = coordinateList.length; i < endi; ++i)
			{
				mPoint.graphics.lineTo(coordinateList[i].x, coordinateList[i].y);
			}
			mPoint.graphics.lineTo(coordinateList[0].x, coordinateList[0].y);
			mPoint.graphics.endFill();
		}
		
		protected function DrawContent():void
		{
			while (mContent.numChildren > 0)
			{
				mContent.removeChildAt(0);
			}
			
			var i:int, endi:int;
			var j:int, endj:int;
			if (mContentTemplate is BoxLabel)
			{
				var labelTemplate:BoxLabel = mContentTemplate as BoxLabel;
				var label:TextField = new TextField();
				label.selectable = false;
				label.width = mSize.width - (mMargin * 2);
				label.text = labelTemplate.Label;
				label.embedFonts = true;
				if (labelTemplate.DropShadow)
				{
					label.filters = [new DropShadowFilter(1.5, 45, 0x000000, 1, 2, 2, 3, BitmapFilterQuality.HIGH)];
				}
				switch (mAutoSizeAxis)
				{
					case Axis.HORIZONTAL:
						label.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName,
							Math.min(mSize.height - (mMargin * 1.5), labelTemplate.Size), labelTemplate.ContentColor,
							null, null, null, null, null, TextFormatAlign.CENTER));
						label.height = mSize.height - (mMargin * 1.5);
						label.autoSize = TextFieldAutoSize.CENTER;
						label.x = -label.width / 2;
						label.y = -label.height / 2 - (mMargin * 0.5);
						break;
					case Axis.VERTICAL:
						label.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName,
							Math.min(mSize.height * 0.75, labelTemplate.Size), labelTemplate.ContentColor,
							null, null, null, null, null, TextFormatAlign.CENTER));
						label.wordWrap = true;
						label.multiline = true;
						label.autoSize = TextFieldAutoSize.CENTER;
						label.x = -label.width / 2;
						label.y = -label.height / 2;
						break;
					case Axis.BOTH:
						label.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName,
							Math.min(mSize.height - (mMargin * 1.5), labelTemplate.Size), labelTemplate.ContentColor,
							null, null, null, null, null, TextFormatAlign.CENTER));
						label.height = mSize.height - (mMargin * 1.5);
						label.autoSize = TextFieldAutoSize.CENTER;
						if (label.width > mDefaultSize.width)
						{
							label.wordWrap = true;
							label.multiline = true;
							label.width = mDefaultSize.width;
						}
						label.x = -label.width / 2;
						label.y = -label.height / 2 - (mMargin * 0.5);
						break;
					default:
						label.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName,
							Math.min(mSize.height * 0.75, labelTemplate.Size), labelTemplate.ContentColor,
							null, null, null, null, null, TextFormatAlign.CENTER));
						label.height = mSize.height - (mMargin * 2);
						label.autoSize = TextFieldAutoSize.CENTER;
						label.x = -label.width / 2;
						label.y = -label.height / 2;
						break;
				}
				mContent.addChild(label);
			}
			else if (mContentTemplate is BoxIcon)
			{
				var iconTemplate:BoxIcon = mContentTemplate as BoxIcon;
				var icon:Bitmap = new iconTemplate.IconAsset();
				icon.smoothing = true;
				icon.width = Math.min(icon.width, mSize.width - (mMargin * 2));
				icon.height = Math.min(icon.height, mSize.height - (mMargin * 2));
				icon.scaleX = icon.scaleY = Math.min(icon.scaleX, icon.scaleY);
				icon.x = (-icon.width / 2);
				icon.y = (-icon.height / 2);
				var colorTransform:ColorTransform = new ColorTransform();
				colorTransform.color = iconTemplate.ContentColor;
				icon.transform.colorTransform = colorTransform;
				mContent.addChild(icon);
			}
			else if (mContentTemplate is BoxTiledLabel)
			{
				var tiledLabelTemplate:BoxTiledLabel = mContentTemplate as BoxTiledLabel;
				var contentList:Vector.<DisplayObject> = new Vector.<DisplayObject>();
				var character:String;
				var characterContainer:Sprite;
				var tileColor:int;
				var characterBox:CurvedBox;
				var punctuationField:TextField;
				var spaceIndex:int;
				for (i = 0, endi = tiledLabelTemplate.Label.length; i < endi; ++i)
				{
					character = tiledLabelTemplate.Label.charAt(i);
					if (i == 0)
					{
						character = character.toUpperCase();
					}
					
					characterContainer = new Sprite();
					
					tileColor = tiledLabelTemplate.TileColorList[tiledLabelTemplate.Label.substring(0, i + 1).split(" ").length - 1];
					
					if (StringUtil.CharIsAlphabet(character))
					{
						characterBox = new CurvedBox(new Point(tiledLabelTemplate.Size, tiledLabelTemplate.Size),
							tileColor, new BoxLabel(character, tiledLabelTemplate.Size * 0.75,
							tiledLabelTemplate.ContentColor), 12, null, Axis.HORIZONTAL);
						characterContainer.addChild(characterBox);
					}
					else if (StringUtil.CharIsPunctuation(character))
					{
						punctuationField = new TextField();
						punctuationField.embedFonts = true;
						punctuationField.autoSize = TextFieldAutoSize.CENTER;
						punctuationField.text = character;
						punctuationField.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName,
							tiledLabelTemplate.Size * 0.75, tiledLabelTemplate.ContentColor,
							null, null, null, null, null, TextFormatAlign.CENTER));
						punctuationField.x = -punctuationField.width / 2;
						punctuationField.y = (-punctuationField.height / 2) - 6;
						characterContainer.addChild(punctuationField);
					}
					else if (character == "_")
					{
						characterBox = new CurvedBox(new Point(tiledLabelTemplate.Size, tiledLabelTemplate.Size),
							tileColor, new BoxLabel("_", tiledLabelTemplate.Size * 0.75,
							//tiledLabelTemplate.ContentColor), 12, null, Axis.HORIZONTAL);
							tileColor), 12, null, Axis.HORIZONTAL);
						characterContainer.addChild(characterBox);
					}
					else if (character == " ")
					{
						characterContainer.graphics.lineStyle();
						characterContainer.graphics.beginFill(0x000000, 0);
						characterContainer.graphics.drawRect(-10, -tiledLabelTemplate.Size / 2,
							20, tiledLabelTemplate.Size);
						characterContainer.graphics.endFill();
					}
					else
					{
						throw new Error("Character " + character + " is not handled.");
					}
					
					mContent.addChild(characterContainer);
					contentList.push(characterContainer);
					
					if (i == 0)
					{
						//characterContainer.x = (-Size.x / 2) + 5 + (characterContainer.width / 2);
						characterContainer.x = (-Size.x / 2) + (characterContainer.width / 2);
						characterContainer.y = 0;
					}
					else
					{
						characterContainer.x = contentList[i - 1].x + (contentList[i - 1].width / 2) +
							(characterContainer.width / 2);
						
						if (characterContainer.x > (Size.x / 2) - 5 - (characterContainer.width / 2))
						{
							spaceIndex = tiledLabelTemplate.Label.lastIndexOf(" ", i);
							if (spaceIndex > -1)
							{
								for (j = spaceIndex + 1, endj = i; j <= endj; ++j)
								{
									if (j == spaceIndex + 1)
									{
										contentList[j].x = (-Size.x / 2) + (contentList[j].width / 2);
										contentList[j].y = contentList[j - 1].y + (contentList[j - 1].height / 2) + 20 +
											(contentList[j].height / 2);
									}
									else
									{
										contentList[j].x = contentList[j - 1].x + (contentList[j - 1].width / 2) +
											(characterContainer.width / 2);
										contentList[j].y = contentList[j - 1].y;
									}
								}
							}
							else
							{
								throw new Error("Unable to find a space where to change line.");
							}
						}
						else
						{
							characterContainer.y = contentList[i - 1].y;
						}
					}
				}
				
				var bounds:Rectangle = mContent.getBounds(this);
				var offset:Point = DisplayObjectUtil.GetPosition(mContent).subtract(new Point(bounds.left + (bounds.width / 2),
					bounds.top + (bounds.height / 2)));
				for (i = 0, endi = contentList.length; i < endi; ++i)
				{
					contentList[i].x += offset.x;
					contentList[i].y += offset.y;
				}
			}
			else
			{
				throw new Error("BoxContent of type " + typeof(mContentTemplate) + " is not handled.");
			}
			
			switch (mAutoSizeAxis)
			{
				case Axis.HORIZONTAL:
				case Axis.VERTICAL:
				case Axis.BOTH:
					Size = Size;
					break;
				default:
					break;
			}
		}
		
		public function EnableMouseOver():void
		{
			addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
		}
		
		public function DisableMouseOver():void
		{
			removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
		}
		
		public function HideLabelSubString(aSubString:String):void
		{
			if (!(mContentTemplate is BoxLabel))
			{
				throw new Error("This box does not have a BoxLabel content.");
				return null;
			}
			
			var field:TextField = mContent.getChildAt(0) as TextField;
			if (!field)
			{
				throw new Error("This box's label is not set.");
			}
			
			var format:TextFormat = field.getTextFormat(0, 1);
			var hiddenFormat:TextFormat = new TextFormat(format.font, format.size, BoxColor, format.bold,
				null, null, null, null, format.align);
			var index:int = field.text.indexOf(aSubString);
			field.setTextFormat(hiddenFormat, index, index + aSubString.length);
		}
		
		public function BoundaryOfLabelSubString(aSubString:String):Rectangle
		{
			if (!(mContentTemplate is BoxLabel))
			{
				throw new Error("This box does not have a BoxLabel content.");
				return null;
			}
			
			var field:TextField = mContent.getChildAt(0) as TextField;
			if (!field)
			{
				throw new Error("This box's label is not set.");
			}
			
			var leftBoundary:Rectangle = field.getCharBoundaries(field.text.indexOf(aSubString));
			var rightBoundary:Rectangle = field.getCharBoundaries(field.text.indexOf(aSubString) + aSubString.length - 1);
			return Geometry.RectangleAdd(leftBoundary.union(rightBoundary), DisplayObjectUtil.GetPosition(field));
		}
		
		private function OnMouseOver(aEvent:MouseEvent):void
		{
			filters = [new GlowFilter(BoxColor, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
		}
		
		private function OnMouseOut(aEvent:MouseEvent):void
		{
			filters = [];
		}
	}
}