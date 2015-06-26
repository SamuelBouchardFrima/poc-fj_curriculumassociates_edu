package com.frimastudio.fj_curriculumassociates_edu.activity
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxIcon;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Geometry;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class ActivityBox extends Box
	{
		private var mWordTemplateList:Vector.<WordTemplate>;
		private var mLineBreakList:Vector.<int>;
		private var mGhostContent:Boolean;
		private var mMegaphoneBtn:CurvedBox;
		private var mWordList:Vector.<Sprite>;
		private var mChunkListList:Vector.<Vector.<CurvedBox>>;
		private var mPunctuationList:Object;
		
		public function get WordTemplateList():Vector.<WordTemplate>	{ return mWordTemplateList; }
		public function set WordTemplateList(aValue:Vector.<WordTemplate>):void
		{
			mWordTemplateList = aValue;
			DrawContent();
		}
		
		public function get CurrentActivityCenter():Point
		{
			var thisPosition:Point = DisplayObjectUtil.GetPosition(this);
			var contentPosition:Point = DisplayObjectUtil.GetPosition(mContent);
			
			for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
			{
				if (mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE)
				{
					return thisPosition.add(contentPosition).add(DisplayObjectUtil.GetPosition(mWordList[i]));
				}
			}
			
			throw new Error("Could not find a word with a corresponding activity. Use SentenceCenter instead.");
			return new Point();
		}
		
		public function get SentenceCenter():Point
		{
			var thisPosition:Point = DisplayObjectUtil.GetPosition(this);
			var contentPosition:Point = DisplayObjectUtil.GetPosition(mContent);
			
			var sentenceBounds:Rectangle = mWordList[0].getBounds(mContent);
			for (var i:int = 0, endi:int = mLineBreakList.length; i < endi; ++i)
			{
				sentenceBounds = sentenceBounds.union(mWordList[mLineBreakList[i] - 1].getBounds(mContent));
			}
			sentenceBounds = sentenceBounds.union(mWordList[mWordList.length - 1].getBounds(mContent));
			
			return thisPosition.add(contentPosition).add(Geometry.RectangleCenter(sentenceBounds));
		}
		
		public function ActivityBox(aWordTemplateList:Vector.<WordTemplate>, aLineBreakList:Vector.<int>, aPhylacteryArrow:Direction,
			aGhostContent:Boolean = false)
		{
			mWordTemplateList = aWordTemplateList;
			mLineBreakList = (aLineBreakList ? aLineBreakList : new Vector.<int>());
			mGhostContent = aGhostContent;
			
			mWordList = new Vector.<Sprite>();
			mChunkListList = new Vector.<Vector.<CurvedBox>>();
			
			super(new Point(1004, ((mLineBreakList.length + 1) * 80) + 40), Palette.DIALOG_BOX, null, 0, aPhylacteryArrow);
			
			mContent.x = -382;
			
			mMegaphoneBtn = new CurvedBox(new Point(80, 80), Palette.GREAT_BTN,
				new BoxIcon(Asset.IconEarBitmap, Palette.BTN_CONTENT));
			mMegaphoneBtn.x = -442;
			mMegaphoneBtn.y = 0;
			mMegaphoneBtn.addEventListener(MouseEvent.CLICK, OnClickMegaphoneBtn);
			addChild(mMegaphoneBtn);
		}
		
		public function Dispose():void
		{
			for (var i:int = 0, endi:int = mWordList.length; i < endi; ++i)
			{
				TweenLite.killTweensOf(mWordList[i]);
				mWordList[i].removeEventListener(MouseEvent.CLICK, OnClickWordAudio);
				mWordList[i].removeEventListener(MouseEvent.CLICK, OnClickWord);
			}
			
			mMegaphoneBtn.removeEventListener(MouseEvent.CLICK, OnClickMegaphoneBtn);
		}
		
		public function UpdateCurrentActivityContent(aChunkList:Vector.<String>, aGhostContent:Boolean = false,
			aOneWord:Boolean = true):void
		{
			mGhostContent = aGhostContent;
			
			var i:int, endi:int;
			var j:int, endj:int;
			if (aOneWord)
			{
				for (i = 0, endi = mWordTemplateList.length; i < endi; ++i)
				{
					if (mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE)
					{
						for (j = 0, endj = mWordTemplateList[i].ChunkList.length; j < endj; ++j)
						{
							mWordTemplateList[i].ChunkList[j] = (j < aChunkList.length ? aChunkList[j] : " ");
						}
						if (i == 0)
						{
							mWordTemplateList[0].ChunkList[0] = mWordTemplateList[0].ChunkList[0].charAt(0).toUpperCase() +
								mWordTemplateList[0].ChunkList[0].substring(1, mWordTemplateList[0].ChunkList[0].length);
						}
						DrawContent();
						return;
					}
				}
			}
			else
			{
				var chunkList:Vector.<String>;
				for (i = 0, endi = mWordTemplateList.length; i < endi; ++i)
				{
					mWordTemplateList[i].ChunkList[0] = (i < aChunkList.length ? aChunkList[i] : " ");
				}
				DrawContent();
			}
		}
		
		public function ProgressWord(aIndex:int):void
		{
			if (mWordTemplateList[aIndex].ActivityToLaunch != ActivityType.NONE)
			{
				mWordTemplateList[aIndex].ActivityToLaunch = ActivityType.NONE;
				mWordTemplateList[aIndex].ColorCode = ActivityType.NONE.ColorCode;
				mWordTemplateList[aIndex].ProgressDone = true;
				mWordTemplateList[aIndex].ChunkList = new <String>[mWordTemplateList[aIndex].ChunkList.join("")];
				DrawContent();
			}
		}
		
		public function ProgressCurrentActivity():void
		{
			for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
			{
				if (mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE)
				{
					mWordTemplateList[i].ActivityToLaunch = ActivityType.NONE;
					mWordTemplateList[i].ColorCode = ActivityType.NONE.ColorCode;
					mWordTemplateList[i].ProgressDone = true;
					mWordTemplateList[i].ChunkList = new <String>[mWordTemplateList[i].ChunkList.join("")];
				}
			}
			DrawContent();
		}
		
		override protected function DrawContent():void
		{
			while (mContent.numChildren > 0)
			{
				mContent.removeChildAt(0);
			}
			mWordList.splice(0, mWordList.length);
			mPunctuationList = { };
			
			var i:int, endi:int;
			var j:int, endj:int;
			var word:Sprite;
			var wordOffset:Point = new Point();
			var chunkList:Vector.<CurvedBox>;
			var chunk:CurvedBox;
			var chunkOffset:Number;
			var label:String;
			var labelColor:int;
			var punctuation:TextField;
			
			for (i = 0, endi = mWordTemplateList.length; i < endi; ++i)
			{
				word = new Sprite();
				chunkList = new Vector.<CurvedBox>();
				chunkOffset = 0;
				for (j = 0, endj = mWordTemplateList[i].ChunkList.length; j < endj; ++j)
				{
					label = mWordTemplateList[i].ChunkList[j];
					labelColor = Palette.DIALOG_CONTENT;
					switch (label)
					{
						case "_":
							label = " ";
							labelColor = mWordTemplateList[i].ColorCode;
							break;
					}
					chunk = new CurvedBox(new Point(60, 60), mWordTemplateList[i].ColorCode, new BoxLabel(label, 45, labelColor),
						12, null, Axis.HORIZONTAL);
					chunkOffset += chunk.width / 2;
					chunk.x = chunkOffset;
					chunk.y = 0;
					word.addChild(chunk);
					chunkList.push(chunk);
					
					chunkOffset += (chunk.width / 2);
				}
				
				chunkOffset = -word.width / 2;
				for (j = 0, endj = chunkList.length; j < endj; ++j)
				{
					chunkList[j].x += chunkOffset;
				}
				
				if (mLineBreakList.indexOf(i) > -1)
				{
					wordOffset.x = 0;
					wordOffset.y += word.height + 20;
				}
				
				wordOffset.x += (word.width / 2);
				word.x = wordOffset.x;
				word.y = wordOffset.y + (word.height / 2);
				
				word.alpha = (mGhostContent && mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE ? 0.5 : 1);
				
				word.graphics.beginFill(0x000000, 0);
				word.graphics.drawRect(-word.width / 2, -word.height / 2, word.width, word.height);
				word.graphics.endFill();
				
				word.addEventListener(MouseEvent.CLICK, OnClickWordAudio);
				
				switch (mWordTemplateList[i].ActivityToLaunch)
				{
					case ActivityType.SENTENCE_DECRYPTING:
					case ActivityType.WORD_UNSCRAMBLING:
					case ActivityType.WORD_CRAFTING:
					case ActivityType.SENTENCE_UNSCRAMBLING:
						word.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 16, 16, 2, BitmapFilterQuality.HIGH)];
						TweenLite.to(word, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowStrong,
							onCompleteParams:[word], glowFilter:{ alpha:0.75 } });
						word.addEventListener(MouseEvent.CLICK, OnClickWord);
						break;
					case ActivityType.NONE:
						if (mWordTemplateList[i].ProgressDone)
						{
							word.filters = [new GlowFilter(Palette.GREAT_BTN, 1, 2, 2, 4, BitmapFilterQuality.HIGH)];
						}
					default:
						break;
				}
				
				mContent.addChild(word);
				mWordList.push(word);
				mChunkListList.push(chunkList);
				wordOffset.x += (word.width / 2);
				
				if (mWordTemplateList[i].Punctuation.length)
				{
					punctuation = new TextField();
					punctuation.embedFonts = true;
					punctuation.selectable = false;
					punctuation.autoSize = TextFieldAutoSize.CENTER;
					punctuation.height = 60;
					punctuation.text = mWordTemplateList[i].Punctuation;
					punctuation.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 45, Palette.DIALOG_CONTENT,
						null, null, null, null, null, TextFormatAlign.CENTER));
					punctuation.x = wordOffset.x;
					punctuation.y = wordOffset.y;
					mContent.addChild(punctuation);
					mPunctuationList[i] = punctuation;
					
					wordOffset.x += punctuation.width;
				}
				if (mWordTemplateList[i].Punctuation != "'")
				{
					wordOffset.x += 10;
				}
			}
			
			//wordOffset = new Point(-mContent.width / 2, -mContent.height / 2);
			wordOffset = new Point(0, -mContent.height / 2);
			for (i = 0, endi = mWordList.length; i < endi; ++i)
			{
				mWordList[i].x += wordOffset.x;
				mWordList[i].y += wordOffset.y;
			}
			for each (punctuation in mPunctuationList)
			{
				punctuation.x += wordOffset.x;
				punctuation.y += wordOffset.y;
			}
		}
		
		private function OnTweenGlowStrong(aWord:Sprite):void
		{
			TweenLite.to(aWord, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowWeak, onCompleteParams:[aWord],
				glowFilter:{ alpha:0.25 } });
		}
		
		private function OnTweenGlowWeak(aWord:Sprite):void
		{
			TweenLite.to(aWord, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowStrong, onCompleteParams:[aWord],
				glowFilter:{ alpha:0.75 } });
		}
		
		private function OnClickWordAudio(aEvent:MouseEvent):void
		{
			var index:int = mWordList.indexOf(aEvent.currentTarget as Sprite);
			// TODO:	ear word sound
		}
		
		private function OnClickWord(aEvent:MouseEvent):void
		{
			var index:int = mWordList.indexOf(aEvent.currentTarget as Sprite);
			dispatchEvent(new ActivityBoxEvent(ActivityBoxEvent.LAUNCH_ACTIVITY, mWordTemplateList[index].ActivityToLaunch));
		}
		
		private function OnClickMegaphoneBtn(aEvent:MouseEvent):void
		{
			// TODO:	ear sentence sound
		}
	}
}