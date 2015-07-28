package com.frimastudio.fj_curriculumassociates_edu.dictionary
{
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	import com.frimastudio.fj_curriculumassociates_edu.util.StringUtil;
	import flash.utils.Dictionary;
	
	public class LetterDistribution
	{
		private static var sDistribution:Dictionary = CreateDistribution();
		private static var sKnownList:String = "mstrdafnpi";
		private static var sDistributedList:String = CreateDistributedList();
		
		public static function get RandomLetter():String	{ return Random.FromString(sDistributedList); }
		
		public static function AddKnownLetter(aLetter:String):void
		{
			var letterList:String = StringUtil.ToLetterOnly(aLetter).toLowerCase();
			for (var i:int = letterList.length - 1, endi:int = 0; i >= endi; --i)
			{
				if (sKnownList.indexOf(letterList.charAt(i)) > -1)
				{
					letterList = letterList.substring(0, i) + letterList.substring(i + 1);
				}
			}
			sKnownList += letterList;
			sDistributedList = CreateDistributedList();
		}
		
		private static function CreateDistribution():Dictionary
		{
			var distribution:Dictionary = new Dictionary();
			distribution["a"] = 9;
			distribution["b"] = 2;
			distribution["c"] = 2;
			distribution["d"] = 4;
			distribution["e"] = 12;
			distribution["f"] = 2;
			distribution["g"] = 3;
			distribution["h"] = 2;
			distribution["i"] = 9;
			distribution["j"] = 1;
			distribution["k"] = 1;
			distribution["l"] = 4;
			distribution["m"] = 2;
			distribution["n"] = 6;
			distribution["o"] = 8;
			distribution["p"] = 2;
			distribution["q"] = 1;
			distribution["r"] = 6;
			distribution["s"] = 4;
			distribution["t"] = 6;
			distribution["u"] = 4;
			distribution["v"] = 2;
			distribution["w"] = 2;
			distribution["x"] = 1;
			distribution["y"] = 2;
			distribution["z"] = 1;
			return distribution;
		}
		
		private static function CreateDistributedList():String
		{
			var distributedList:String = "";
			var emptyList:Vector.<String> = new <String>["", "", "", "", "", "", "", "", "", "", "", ""];
			var char:String;
			for (var i:int = 0, endi:int = sKnownList.length; i < endi; ++i)
			{
				char = sKnownList.charAt(i);
				distributedList += emptyList.slice(0, sDistribution[char] + 1).join(char);
			}
			return distributedList;
		}
		
		public function LetterDistribution()
		{
			throw new Error("LetterDistribution is static and not intended for instantiation.");
		}
	}
}