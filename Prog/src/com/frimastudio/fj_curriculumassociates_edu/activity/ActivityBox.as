package com.frimastudio.fj_curriculumassociates_edu.activity
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class ActivityBox extends Box
	{
		private var mWordTemplateList:Vector.<WordTemplate>;
		private var mGhostContent:Boolean;
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
			for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
			{
				if (mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE)
				{
					return DisplayObjectUtil.GetPosition(this).add(DisplayObjectUtil.GetPosition(mWordList[i]));
				}
			}
			
			return DisplayObjectUtil.GetPosition(this);
		}
		
		public function ActivityBox(aWordTemplateList:Vector.<WordTemplate>, aGhostContent:Boolean = false)
		{
			mWordTemplateList = aWordTemplateList;
			mGhostContent = aGhostContent;
			mWordList = new Vector.<Sprite>();
			mChunkListList = new Vector.<Vector.<CurvedBox>>();
			
			super(new Point(1004, 200), Palette.DIALOG_BOX);
		}
		
		public function Dispose():void
		{
			for (var i:int = 0, endi:int = mWordList.length; i < endi; ++i)
			{
				TweenLite.killTweensOf(mWordList[i]);
				mWordList[i].removeEventListener(MouseEvent.CLICK, OnClickWord);
			}
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
						DrawContent();
						return;
					}
				}
			}
			else
			{
				//var chunkList:Vector.<String> = 
				var chunkList:Vector.<String>;
				for (i = 0, endi = mWordTemplateList.length; i < endi; ++i)
				{
					//chunkList = new <String>[i < aChunkList.length ? aChunkList[i] : " "];
					mWordTemplateList[i].ChunkList[0] = (i < aChunkList.length ? aChunkList[i] : " ");
					//mWordTemplateList[i].ChunkList = new <String>[i < aChunkList.length ? aChunkList[i] : " "];
					//for (j = 0, endj = mWordTemplateList[i].ChunkList.length; j < endj; ++j)
					//{
						//mWordTemplateList[i].ChunkList[j] = (j < aChunkList.length ? aChunkList[j] : " ");
					//}
				}
				DrawContent();
			}
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
				
				wordOffset.x += (word.width / 2);
				word.x = wordOffset.x;
				word.y = wordOffset.y + (word.height / 2);
				
				word.alpha = (mGhostContent && mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE ? 0.5 : 1);
				
				word.graphics.beginFill(0x000000, 0);
				word.graphics.drawRect(-word.width / 2, -word.height / 2, word.width, word.height);
				word.graphics.endFill();
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
					default:
						break;
				}
				
				mContent.addChild(word);
				if (word.getBounds(mContent).right > 900)
				{
					wordOffset.x = (word.width / 2);
					wordOffset.y += word.height + 20;
					
					word.x = wordOffset.x;
					word.y = wordOffset.y + (word.height / 2);
				}
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
			
			wordOffset = new Point(-mContent.width / 2, -mContent.height / 2);
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
		
		private function OnClickWord(aEvent:MouseEvent):void
		{
			var index:int = mWordList.indexOf(aEvent.currentTarget as Sprite);
			dispatchEvent(new ActivityBoxEvent(ActivityBoxEvent.LAUNCH_ACTIVITY, mWordTemplateList[index].ActivityToLaunch));
		}
	}
}