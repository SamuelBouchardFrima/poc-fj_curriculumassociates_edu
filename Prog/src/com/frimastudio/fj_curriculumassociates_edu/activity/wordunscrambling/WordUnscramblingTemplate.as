package com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	
	public class WordUnscramblingTemplate extends ActivityTemplate
	{
		private var mLetterList:Vector.<String>;
		private var mAnswer:String;
		private var mActivityWordList:Vector.<WordTemplate>;
		
		public function get LetterList():Vector.<String>	{ return mLetterList; }
		public function get Answer():String	{ return mAnswer; }
		public function get ActivityWordList():Vector.<WordTemplate>	{ return mActivityWordList; }
		
		public function WordUnscramblingTemplate(aLevel:Level, aLetterList:Vector.<String>, aAnswer:String,
			aActivityWordList:Vector.<WordTemplate>)
		{
			super(aLevel);
			
			mStepClass = WordUnscrambling;
			
			mLetterList = aLetterList;
			mAnswer = aAnswer;
			mActivityWordList = aActivityWordList;
		}
	}
}