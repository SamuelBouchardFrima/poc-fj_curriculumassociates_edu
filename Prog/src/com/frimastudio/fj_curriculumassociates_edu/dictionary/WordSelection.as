package com.frimastudio.fj_curriculumassociates_edu.dictionary
{
	internal class WordSelection
	{
		private static var sRhymingSelection:Object = {};
		private static var sAlliteratingSelection:Object = {};
		
		public static function RhymingSelection(aRhyme:String, aGrade:int, aGradeData:XML):Vector.<String>
		{
			if (sRhymingSelection[aRhyme + "_" + aGrade])
			{
				return sRhymingSelection[aRhyme + "_" + aGrade];
			}
			
			var selection:Vector.<String> = new Vector.<String>();
			
			var text:XMLList = aGradeData.text();
			if (!text[0])
			{
				sRhymingSelection[aRhyme + "_" + aGrade] = selection;
				return selection;
			}
			
			var parsedData:Array = text[0].split("\n");
			var word:String;
			for (var i:int = 1, end:int = parsedData.length - 1; i < end; ++i)
			{
				word = parsedData[i];
				word = word.substr(0, word.length - 1);
				
				if (word == "" || word.indexOf("'") != -1 || word.indexOf("-") != -1 || word.indexOf(" ") != -1 ||
					word.indexOf(",") != -1 || word.indexOf(";") != -1 || word.indexOf(":") != -1 ||
					word.indexOf(".") != -1 || word.indexOf("!") != -1 || word.indexOf("?") != -1)
				{
					continue;
				}
				
				if (word.lastIndexOf(aRhyme) == word.length - aRhyme.length)
				{
					if (selection.indexOf(selection) == -1)
					{
						selection.push(word);
					}
				}
			}
			
			sRhymingSelection[aRhyme + "_" + aGrade] = selection;
			return selection;
		}
		
		public static function AlliteratingSelection(aAlliteration:String, aGrade:int, aGradeData:XML):Vector.<String>
		{
			if (sAlliteratingSelection[aAlliteration + "_" + aGrade])
			{
				return sAlliteratingSelection[aAlliteration + "_" + aGrade];
			}
			
			var selection:Vector.<String> = new Vector.<String>();
			
			var text:XMLList = aGradeData.text();
			if (!text[0])
			{
				sAlliteratingSelection[aAlliteration + "_" + aGrade] = selection;
				return selection;
			}
			
			var parsedData:Array = text[0].split("\n");
			var word:String;
			for (var i:int = 1, end:int = parsedData.length - 1; i < end; ++i)
			{
				word = parsedData[i];
				word = word.substr(0, word.length - 1);
				
				if (word == "" || word.indexOf("'") != -1 || word.indexOf("-") != -1 || word.indexOf(" ") != -1 ||
					word.indexOf(",") != -1 || word.indexOf(";") != -1 || word.indexOf(":") != -1 ||
					word.indexOf(".") != -1 || word.indexOf("!") != -1 || word.indexOf("?") != -1)
				{
					continue;
				}
				
				if (word.indexOf(aAlliteration) == 0)
				{
					if (selection.indexOf(selection) == -1)
					{
						selection.push(word);
					}
				}
			}
			
			sAlliteratingSelection[aAlliteration + "_" + aGrade] = selection;
			return selection;
		}
		
		public function WordSelection()
		{
			throw new Error("WordSelection is static and not intended for instantiation.");
		}
	}
}