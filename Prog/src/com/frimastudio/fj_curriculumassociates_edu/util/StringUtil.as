package com.frimastudio.fj_curriculumassociates_edu.util
{
	public class StringUtil
	{
		public static function CharIsAlphabet(aCharacter:String):Boolean
		{
			if (aCharacter.length != 1)
			{
				throw new Error("String with length 1 is expected.");
				return false;
			}
			
			return (CharIsUpperCase(aCharacter) || CharIsLowerCase(aCharacter));
		}
		
		public static function CharIsUpperCase(aCharacter:String):Boolean
		{
			if (aCharacter.length != 1)
			{
				throw new Error("String with length 1 is expected.");
				return false;
			}
			
			return (aCharacter.charCodeAt(0) >= 65 && aCharacter.charCodeAt(0) <= 90);	// A-Z
		}
		
		public static function CharIsLowerCase(aCharacter:String):Boolean
		{
			if (aCharacter.length != 1)
			{
				throw new Error("String with length 1 is expected.");
				return false;
			}
			
			return (aCharacter.charCodeAt(0) >= 97 && aCharacter.charCodeAt(0) <= 122);	// a-z
		}
		
		public static function CharIsPunctuation(aCharacter:String):Boolean
		{
			if (aCharacter.length != 1)
			{
				throw new Error("String with length 1 is expected.");
				return false;
			}
			
			switch (aCharacter.charCodeAt(0))
			{
				case 33:	// !
				case 34:	// "
				case 39:	// '
				case 44:	// ,
				case 45:	// -
				case 46:	// .
				case 58:	// :
				case 59:	// ;
				case 63:	// ?
				case 96:	// `
					return true;
				default:
					return false;
			}
		}
		
		public function StringUtil()
		{
			throw new Error("StringUtil is a static class not intended for instantiation.");
		}
	}
}