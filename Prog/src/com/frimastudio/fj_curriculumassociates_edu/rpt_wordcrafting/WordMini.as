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
				new <String>["h", "i", "l", "l"]];
			mDecomposedPiece["felt"] = new <Vector.<String>>[new <String>["f", "e", "lt"], new <String>["f", "elt"],
				new <String>["f", "e", "l", "t"]];
			mDecomposedPiece["hall"] = new <Vector.<String>>[new <String>["h", "all"], new <String>["h", "a", "ll"],
				new <String>["h", "a", "l", "l"]];
			mDecomposedPiece["clam"] = new <Vector.<String>>[new <String>["c", "l", "am"], new <String>["c", "l", "a", "m"],
				new <String>["cl", "am"], new <String>["cl", "a", "m"]];
			mDecomposedPiece["leaf"] = new <Vector.<String>>[new <String>["l", "e", "af"], new <String>["l", "e", "a", "f"]];
			mDecomposedPiece["surf"] = new <Vector.<String>>[new <String>["s", "u", "rf"], new <String>["s", "urf"],
				new <String>["s", "u", "r", "f"]];
			mDecomposedPiece["fair"] = new <Vector.<String>>[new <String>["f", "a", "ir"], new <String>["f", "a", "i", "r"]];
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