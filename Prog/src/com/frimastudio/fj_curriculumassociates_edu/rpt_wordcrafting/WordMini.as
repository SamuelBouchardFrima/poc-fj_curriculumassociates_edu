package com.frimastudio.fj_curriculumassociates_edu.rpt_wordcrafting
{
	import com.frimastudio.fj_curriculumassociates_edu.Mini;
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	internal class WordMini extends Mini
	{
		private var mDecomposedPiece:Dictionary;
		
		public function WordMini()
		{
			super(0x99EEFF);
			
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
		
		public function CraftWord(aWord:String):Vector.<String>
		{
			EatWord(aWord);
			
			var decomposedPossibility:Vector.<Vector.<String>> = mDecomposedPiece[aWord] as Vector.<Vector.<String>>;
			if (!decomposedPossibility)
			{
				throw new Error("Word " + aWord + " is not implemented!");
				return null;
			}
			
			return Random.FromList(decomposedPossibility) as Vector.<String>;
		}
	}
}