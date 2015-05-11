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
		private var mDecomposedPiece:Dictionary;
		
		public function WordMini()
		{
			super();
			
			mAsset = new Sprite();
			addChild(mAsset);
			
			mAsset.graphics.lineStyle(2);
			mAsset.graphics.beginFill(0x99EEFF);
			mAsset.graphics.drawEllipse(-100, -75, 200, 150);
			mAsset.graphics.endFill();
			mAsset.graphics.beginFill(0x000000);
			mAsset.graphics.drawCircle(-30, -25, 20);
			mAsset.graphics.drawCircle(30, -25, 20);
			mAsset.graphics.endFill();
			mAsset.graphics.moveTo(-60, 0);
			mAsset.graphics.curveTo(-50, 30, 0, 30);
			mAsset.graphics.curveTo(50, 30, 60, 0);
			
			mTimer = new Timer(1500, 1);
			mTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
			
			mDecomposedPiece = new Dictionary();
			mDecomposedPiece["hill"] = new <Vector.<String>>[new <String>["h", "ill"], new <String>["h", "i", "ll"],
				new <String>["h", "i", "l", "l"], new <String>["h", "il", "l"]];
			mDecomposedPiece["felt"] = new <Vector.<String>>[new <String>["f", "e", "lt"], new <String>["f", "elt"],
				new <String>["f", "e", "l", "t"], new <String>["f", "el", "t"]];
			mDecomposedPiece["hall"] = new <Vector.<String>>[new <String>["h", "all"], new <String>["h", "a", "ll"],
				new <String>["h", "a", "l", "l"], new <String>["h", "al", "l"]];
			mDecomposedPiece["spin"] = new <Vector.<String>>[new <String>["sp", "i", "n"], new <String>["sp", "in"],
				new <String>["s", "p", "i", "n"], new <String>["s", "p", "in"]];
			mDecomposedPiece["trap"] = new <Vector.<String>>[new <String>["tr", "a", "p"], new <String>["tr", "ap"],
				new <String>["t", "r", "a", "p"], new <String>["t", "r", "ap"]];
			mDecomposedPiece["damp"] = new <Vector.<String>>[new <String>["d", "a", "mp"], new <String>["d", "amp"],
				new <String>["d", "a", "m", "p"], new <String>["d", "am", "p"]];
			mDecomposedPiece["honk"] = new <Vector.<String>>[new <String>["h", "o", "nk"], new <String>["h", "onk"],
				new <String>["h", "o", "n", "k"], new <String>["h", "on", "k"]];
		}
		
		public function EatWord(aWord:String):Vector.<String>
		{
			mAsset.graphics.clear();
			mAsset.graphics.lineStyle(2);
			mAsset.graphics.beginFill(0x99EEFF);
			mAsset.graphics.drawEllipse(-100, -75, 200, 150);
			mAsset.graphics.endFill();
			mAsset.graphics.moveTo(-50, -25);
			mAsset.graphics.lineTo(-10, -25);
			mAsset.graphics.moveTo(10, -25);
			mAsset.graphics.lineTo(50, -25);
			mAsset.graphics.beginFill(0x000000);
			mAsset.graphics.drawEllipse(-50, -10, 100, 50);
			mAsset.graphics.endFill();
			
			mTimer.reset();
			mTimer.start();
			
			var decomposedPossibility:Vector.<Vector.<String>> = mDecomposedPiece[aWord] as Vector.<Vector.<String>>;
			if (!decomposedPossibility)
			{
				throw new Error("Word " + aWord + " is not implemented!");
				return null;
			}
			
			return Random.FromList(decomposedPossibility) as Vector.<String>;
		}
		
		private function OnTimerComplete(aEvent:TimerEvent):void
		{
			mAsset.graphics.clear();
			mAsset.graphics.lineStyle(2);
			mAsset.graphics.beginFill(0x99EEFF);
			mAsset.graphics.drawEllipse(-100, -75, 200, 150);
			mAsset.graphics.endFill();
			mAsset.graphics.beginFill(0x000000);
			mAsset.graphics.drawCircle(-30, -25, 20);
			mAsset.graphics.drawCircle(30, -25, 20);
			mAsset.graphics.endFill();
			mAsset.graphics.moveTo(-60, 0);
			mAsset.graphics.curveTo(-50, 30, 0, 30);
			mAsset.graphics.curveTo(50, 30, 60, 0);
		}
	}
}