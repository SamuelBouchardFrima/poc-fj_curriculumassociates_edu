package com.frimastudio.fj_curriculumassociates_edu.activity
{
	import com.frimastudio.fj_curriculumassociates_edu.dialog.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	public class ActivityBox extends Box
	{
		private var mWordTemplateList:Vector.<WordTemplate>;
		private var mWordList:Vector.<Sprite>;
		private var mChunkListList:Vector.<Vector.<CurvedBox>>;
		
		public function ActivityBox(aWordTemplateList:Vector.<WordTemplate>)
		{
			mWordTemplateList = aWordTemplateList;
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
		
		override protected function DrawContent():void
		{
			while (mContent.numChildren > 0)
			{
				mContent.removeChildAt(0);
			}
			mWordList.splice(0, mWordList.length);
			
			var i:int, endi:int;
			var j:int, endj:int;
			var word:Sprite;
			var wordOffset:Point = new Point();
			var chunkList:Vector.<CurvedBox>;
			var chunk:CurvedBox;
			var chunkOffset:Number;
			var label:String;
			
			for (i = 0, endi = mWordTemplateList.length; i < endi; ++i)
			{
				word = new Sprite();
				chunkList = new Vector.<CurvedBox>();
				chunkOffset = 0;
				for (j = 0, endj = mWordTemplateList[i].ChunkList.length; j < endj; ++j)
				{
					label = mWordTemplateList[i].ChunkList[j];
					switch (label)
					{
						case "_":
							label = "?";
							break;
					}
					chunk = new CurvedBox(new Point(60, 60), mWordTemplateList[i].ColorCode,
						new BoxLabel(label, 45, Palette.DIALOG_CONTENT), 12, null, Axis.HORIZONTAL);
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
				wordOffset.x += (word.width / 2) + 20;
			}
			
			wordOffset = new Point(-mContent.width / 2, -mContent.height / 2);
			for (i = 0, endi = mWordList.length; i < endi; ++i)
			{
				mWordList[i].x += wordOffset.x;
				mWordList[i].y += wordOffset.y;
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