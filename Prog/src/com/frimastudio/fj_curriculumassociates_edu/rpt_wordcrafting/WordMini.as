package com.frimastudio.fj_curriculumassociates_edu.rpt_wordcrafting
{
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	internal class WordMini extends Sprite
	{
		private var mAsset:Sprite;
		private var mTimer:Timer;
		private var mCurrentWord:String;
		private var mDecomposedPiece:Dictionary;
		
		public function WordMini()
		{
			super();
			
			mAsset = new Sprite();
			addChild(mAsset);
			
			mAsset.graphics.lineStyle(2);
			mAsset.graphics.beginFill(0x99EEFF);
			mAsset.graphics.drawCircle(0, 0, 50);
			mAsset.graphics.endFill();
			mAsset.graphics.moveTo(-20, -15);
			mAsset.graphics.lineTo(-10, -15);
			mAsset.graphics.moveTo(10, -15);
			mAsset.graphics.lineTo(20, -15);
			mAsset.graphics.beginFill(0x000000);
			mAsset.graphics.drawCircle(-15, -5, 5);
			mAsset.graphics.drawCircle(15, -5, 5);
			mAsset.graphics.endFill();
			mAsset.graphics.moveTo(-35, 10);
			mAsset.graphics.lineTo(35, 10);
			
			mTimer = new Timer(1000, 1);
			mTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
			
			mDecomposedPiece = new Dictionary();
			mDecomposedPiece["hill"] = new <Vector.<String>>[new <String>["h", "ill"], new <String>["hi", "l", "l"], new <String>["h", "il", "l"]];
			mDecomposedPiece["felt"] = new <Vector.<String>>[new <String>["fe", "l", "t"], new <String>["f", "e", "lt"], new <String>["f", "el", "t"]];
			mDecomposedPiece["hall"] = new <Vector.<String>>[new <String>["ha", "ll"], new <String>["hal", "l"], new <String>["h", "all"]];
			mDecomposedPiece["spin"] = new <Vector.<String>>[new <String>["s", "pin"], new <String>["sp", "i", "n"], new <String>["s", "p", "in"]];
			mDecomposedPiece["trap"] = new <Vector.<String>>[new <String>["t", "ra", "p"], new <String>["tr", "ap"], new <String>["tra", "p"]];
			mDecomposedPiece["damp"] = new <Vector.<String>>[new <String>["dam", "p"], new <String>["d", "amp"], new <String>["da", "m", "p"]];
			mDecomposedPiece["honk"] = new <Vector.<String>>[new <String>["ho", "n", "k"], new <String>["h", "o", "nk"], new <String>["h", "on", "k"]];
		}
		
		public function EatWord(aWord:String):void
		{
			mCurrentWord = aWord;
			
			mAsset.graphics.clear();
			mAsset.graphics.lineStyle(2);
			mAsset.graphics.beginFill(0x99EEFF);
			mAsset.graphics.drawCircle(0, 0, 50);
			mAsset.graphics.endFill();
			mAsset.graphics.moveTo(-20, -15);
			mAsset.graphics.lineTo(-10, -17);
			mAsset.graphics.moveTo(10, -17);
			mAsset.graphics.lineTo(20, -15);
			mAsset.graphics.moveTo(-20, -5);
			mAsset.graphics.lineTo(-10, -5);
			mAsset.graphics.moveTo(10, -5);
			mAsset.graphics.lineTo(20, -5);
			mAsset.graphics.beginFill(0x000000);
			mAsset.graphics.drawCircle(0, 15, 15);
			mAsset.graphics.endFill();
			
			mTimer.reset();
			mTimer.start();
		}
		
		private function OnTimerComplete(aEvent:TimerEvent):void
		{
			mAsset.graphics.clear();
			mAsset.graphics.lineStyle(2);
			mAsset.graphics.beginFill(0x99EEFF);
			mAsset.graphics.drawCircle(0, 0, 50);
			mAsset.graphics.endFill();
			mAsset.graphics.moveTo(-20, -15);
			mAsset.graphics.lineTo(-10, -15);
			mAsset.graphics.moveTo(10, -15);
			mAsset.graphics.lineTo(20, -15);
			mAsset.graphics.beginFill(0x000000);
			mAsset.graphics.drawCircle(-15, -5, 5);
			mAsset.graphics.drawCircle(15, -5, 5);
			mAsset.graphics.endFill();
			mAsset.graphics.moveTo(-35, 10);
			mAsset.graphics.lineTo(35, 10);
			
			var decomposedPossibility:Vector.<Vector.<String>> = mDecomposedPiece[mCurrentWord] as Vector.<Vector.<String>>;
			if (!decomposedPossibility)
			{
				throw new Error("Word " + mCurrentWord + " is not implemented!");
				return;
			}
			
			dispatchEvent(new WordMiniEvent(WordMiniEvent.BURP_PIECE, Random.FromList(decomposedPossibility) as Vector.<String>));
		}
	}
}