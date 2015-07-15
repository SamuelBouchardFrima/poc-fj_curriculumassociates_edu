package com.frimastudio.fj_curriculumassociates_edu.inventory
{
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	
	public class Inventory
	{
		private static const TEMP_WORD_LIST:Array/*String*/ = ["tip", "rip", "dim", "fin", "sit",
			"sip", "pit", "rid", "in", "rat", "fat", "if", "did"];
		
		public static function RequestWordSelection(aLetterList:String):Vector.<String>
		{
			var letterList:String = aLetterList.toLowerCase();
			var wordSelection:Vector.<String> = new Vector.<String>();
			var wordList:Vector.<String> = Vector.<String>(TEMP_WORD_LIST);
			var indexList:Vector.<int>;
			var i:int, endi:int;
			var j:int, endj:int;
			for (i = 0, endi = letterList.length; i < endi; ++i)
			{
				indexList = new Vector.<int>();
				for (j = 0, endj = wordList.length; j < endj; ++j)
				{
					if (wordList[j].indexOf(letterList.charAt(i)) > -1)
					{
						indexList.push(j);
					}
				}
				if (indexList.length)
				{
					wordSelection.push(wordList.splice(Random.FromList(indexList) as int, 1)[0]);
				}
			}
			return wordSelection;
		}
		
		public function Inventory()
		{
			throw new Error("Inventory is static and not intended for instantiation.");
		}
	}
}