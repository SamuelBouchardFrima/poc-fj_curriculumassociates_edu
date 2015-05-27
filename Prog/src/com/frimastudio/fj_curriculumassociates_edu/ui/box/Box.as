package com.frimastudio.fj_curriculumassociates_edu.ui.box
{
	import com.frimastudio.fj_curriculumassociates_edu.FontList;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Geometry;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Box extends Sprite
	{
		protected var mSize:Rectangle;
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
		
		public function Box(aSize:Point, aColor:int = NaN, aContent:BoxContent = null, aMargin:Number = 0,
			aPointDirection:Direction = null, aAutoSizeAxis:Axis = null)
		{
			super();
			
			mSize = new Rectangle(-aSize.x / 2, -aSize.y / 2, aSize.x, aSize.y);
			mColor = (isNaN(aColor) ? Palette.GENERIC_BTN : aColor);
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
					coordinateList.push(new Point(13, mSize.bottom - 5));
					coordinateList.push(new Point(0, mSize.bottom + 20));
					coordinateList.push(new Point(0, mSize.bottom - 5));
					break;
				case Direction.LEFT:
					coordinateList.push(new Point(mSize.left + 5, -13));
					coordinateList.push(new Point(mSize.left - 20, 0));
					coordinateList.push(new Point(mSize.left + 5, 0));
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
			
			if (mContentTemplate is BoxLabel)
			{
				var labelTemplate:BoxLabel = mContentTemplate as BoxLabel;
				var label:TextField = new TextField();
				label.selectable = false;
				label.width = mSize.width - (mMargin * 2);
				label.text = labelTemplate.Label;
				if (labelTemplate.DropShadow)
				{
					label.filters = [new DropShadowFilter(1.5, 45, 0x000000, 1, 2, 2, 3, BitmapFilterQuality.HIGH)];
				}
				switch (mAutoSizeAxis)
				{
					case Axis.HORIZONTAL:
						label.setTextFormat(new TextFormat(FontList.SEMI_BOLD, Math.min(mSize.height - (mMargin * 1.5),
							labelTemplate.Size), labelTemplate.ContentColor, null, null, null, null, null, "center"));
						label.height = mSize.height - (mMargin * 1.5);
						label.autoSize = TextFieldAutoSize.CENTER;
						label.x = -label.width / 2;
						label.y = -label.height / 2 - (mMargin * 0.5);
						break;
					case Axis.VERTICAL:
						label.setTextFormat(new TextFormat(FontList.SEMI_BOLD, Math.min(mSize.height * 0.75, labelTemplate.Size),
							labelTemplate.ContentColor, null, null, null, null, null, "center"));
						label.wordWrap = true;
						label.multiline = true;
						label.autoSize = TextFieldAutoSize.CENTER;
						label.x = -label.width / 2;
						label.y = -label.height / 2;
						break;
					default:
						label.setTextFormat(new TextFormat(FontList.SEMI_BOLD, Math.min(mSize.height * 0.75, labelTemplate.Size),
							labelTemplate.ContentColor, null, null, null, null, null, "center"));
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
				icon.x = (-icon.width / 2);
				icon.y = (-icon.height / 2);
				var colorTransform:ColorTransform = new ColorTransform();
				colorTransform.color = iconTemplate.ContentColor;
				icon.transform.colorTransform = colorTransform;
				mContent.addChild(icon);
			}
			else
			{
				throw new Error("BoxContent of type " + typeof(mContentTemplate) + " is not handled.");
			}
			
			switch (mAutoSizeAxis)
			{
				case Axis.HORIZONTAL:
				case Axis.VERTICAL:
					Size = Size;
					break;
				default:
					break;
			}
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
	}
}