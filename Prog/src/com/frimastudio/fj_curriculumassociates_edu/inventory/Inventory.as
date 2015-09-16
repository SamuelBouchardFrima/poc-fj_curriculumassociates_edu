package com.frimastudio.fj_curriculumassociates_edu.inventory
{
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	import flash.events.AccelerometerEvent;
	
	public class Inventory
	{
		//private static const TEMP_WORD_LIST:Array/*String*/ = ["tip", "rip", "dim", "fin", "sit",
			//"sip", "pit", "rid", "in", "rat", "fat", "if", "did"];
		
		private static var sWordList:Array/*Sring*/ = [];
		private static var sLetterPatternCardList:Array/*Sring*/ = [];
		private static var sSelectedLetterPatternCardList:Vector.<String> = new Vector.<String>();
		private static var sCompletedLucuTamingWordList:Vector.<String> = new Vector.<String>();
		static private var sSelectableLucuTamingWord:int = 0;
		
		public static function AddWord(aWord:String):void
		{
			sWordList.push(aWord);
		}
		
		public static function RemoveWord(aWord:String):void
		{
			//var i:int, endi:int;
			//for (i = 0, endi = sWordList.length; i < endi; ++i)
			//{
				//if (sWordList[i] == aWord)
				//{
					//sWordList.splice(i, 1);
					//return;
				//}
			//}
		}
		
		public static function RequestWordSelection(aLetterList:String):Vector.<String>
		{
			var letterList:String = aLetterList.toLowerCase();
			var handledLetterList:String = "";
			var wordSelection:Vector.<String> = new Vector.<String>();
			//var wordList:Vector.<String> = Vector.<String>(TEMP_WORD_LIST);
			var wordList:Vector.<String> = Vector.<String>(sWordList);
			var indexList:Vector.<int>;
			var i:int, endi:int;
			var j:int, endj:int;
			var char:String;
			//var needMoreWords:Boolean;
			for (i = 0, endi = letterList.length; i < endi; ++i)
			{
				char = letterList.charAt(i);
				if (char == "*")
				{
					if (wordList.length)
					{
						wordSelection.push(wordList.splice(wordList.indexOf(Random.FromList(wordList)), 1));
						handledLetterList += wordSelection[wordSelection.length - 1];
					}
				}
				
				if (handledLetterList.split(char).length < letterList.split(char).length)
				{
					indexList = new Vector.<int>();
					for (j = 0, endj = wordList.length; j < endj; ++j)
					{
						if (wordList[j].indexOf(char) > -1)
						{
							indexList.push(j);
						}
					}
					if (indexList.length)
					{
						wordSelection.push(wordList.splice(Random.FromList(indexList) as int, 1)[0]);
						handledLetterList += wordSelection[wordSelection.length - 1];
					}
					else
					{
						//needMoreWords = true;
						//wordSelection.push("_");
					}
				}
			}
			
			var index:int;
			for (i = 0, endi = Math.min(wordList.length, 3); i < endi; ++i)
			{
				index = Random.RangeInt(0, wordList.length - 1);
				wordSelection.push(wordList.splice(index, 1)[0]);
			}
			
			//if (needMoreWords)
			//{
				//wordSelection.unshift("+");
			//}
			return wordSelection;
		}
		
		public static function AddLetterPatternCard(aCard:String):void
		{
			sLetterPatternCardList.push(aCard);
		}
		
		public static function RemoveLetterPatternCard(aCard:String):void
		{
			var i:int, endi:int;
			for (i = 0, endi = sLetterPatternCardList.length; i < endi; ++i)
			{
				if (sLetterPatternCardList[i] == aCard)
				{
					sLetterPatternCardList.splice(i, 1);
					return;
				}
			}
		}
		
		public static function get SelectedLetterPatternCardList():Vector.<String>
		{
			return sSelectedLetterPatternCardList;
		}
		
		public static function SelectLetterPatternCardList(aCardList:Vector.<String>):void
		{
			sSelectedLetterPatternCardList = aCardList;
		}
		
		public static function UnselectLetterPatternCardList():void
		{
			sSelectedLetterPatternCardList.splice(0, sSelectedLetterPatternCardList.length);
		}
		
		public static function get CompletedLucuTamingWordList():Vector.<String>	{ return sCompletedLucuTamingWordList; }
		public static function set CompletedLucuTamingWordList(aValue:Vector.<String>):void	{ sCompletedLucuTamingWordList = aValue; }
		
		public static function get SelectableLucuTamingWord():int	{ return sSelectableLucuTamingWord; }
		public static function set SelectableLucuTamingWord(aValue:int):void	{ sSelectableLucuTamingWord = aValue; }
		
		public static function Reset():void
		{
			sWordList = [];
			sLetterPatternCardList = [];
			sSelectedLetterPatternCardList.splice(0, sSelectedLetterPatternCardList.length);
			sCompletedLucuTamingWordList.splice(0, sCompletedLucuTamingWordList.length);
			sSelectableLucuTamingWord = 0;
		}
		
		public function Inventory()
		{
			throw new Error("Inventory is static and not intended for instantiation.");
		}
	}
}