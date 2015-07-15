package com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	
	public class WordUnscramblingTemplate extends ActivityTemplate
	{
		//private var mLetterList:Vector.<String>;
		//private var mAnswer:String;
		private var mScrambledWord:ScrambledWordTemplate;
		private var mRequestVO:Class;
		private var mActivityWordList:Vector.<WordTemplate>;
		private var mLineBreakList:Vector.<int>;
		private var mPhylacteryArrow:Direction;
		
		//public function get LetterList():Vector.<String>	{ return mLetterList; }
		public function get Answer():String	{ return mScrambledWord.Answer; }
		public function get ScrambledWord():ScrambledWordTemplate	{ return mScrambledWord; }
		public function get RequestVO():Class	{ return mRequestVO; }
		public function get ActivityWordList():Vector.<WordTemplate>	{ return mActivityWordList; }
		public function get LineBreakList():Vector.<int>	{ return mLineBreakList; }
		public function get PhylacteryArrow():Direction	{ return mPhylacteryArrow; }
		
		//public function WordUnscramblingTemplate(aLevel:Level, aLetterList:Vector.<String>, aAnswer:String, aRequestVO:Class,
		public function WordUnscramblingTemplate(aLevel:Level, aScrambledWord:ScrambledWordTemplate, aRequestVO:Class,
			aActivityWordList:Vector.<WordTemplate>, aLineBreakList:Vector.<int> = null, aPhylacteryArrow:Direction = null)
		{
			super(aLevel);
			
			mStepClass = WordUnscrambling;
			
			//mLetterList = aLetterList;
			//mAnswer = aAnswer;
			mScrambledWord = aScrambledWord;
			mRequestVO = aRequestVO;
			mActivityWordList = aActivityWordList;
			mLineBreakList = (aLineBreakList ? aLineBreakList : new Vector.<int>());
			mPhylacteryArrow = (aPhylacteryArrow ? aPhylacteryArrow : Direction.DOWN_LEFT);
		}
	}
}