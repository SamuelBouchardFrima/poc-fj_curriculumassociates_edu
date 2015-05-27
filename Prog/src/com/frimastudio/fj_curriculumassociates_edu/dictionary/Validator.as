package com.frimastudio.fj_curriculumassociates_edu.dictionary
{
	internal class Validator
	{
		private var mWordDictionary:Object;
		
		public function Validator(aData:XML)
		{
			mWordDictionary = { };
			
			var text:XMLList = aData.text();
			if (!text[0])
			{
				return;
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
				
				mWordDictionary[word] = true;
			}
		}
		
		public function Validate(aWord:String):Boolean
		{
			return mWordDictionary[aWord];
		}
	}
}