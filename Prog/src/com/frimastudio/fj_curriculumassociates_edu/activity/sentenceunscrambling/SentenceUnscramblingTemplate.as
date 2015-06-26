package com.frimastudio.fj_curriculumassociates_edu.activity.sentenceunscrambling
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	
	public class SentenceUnscramblingTemplate extends ActivityTemplate
	{
		private var mWordList:Vector.<String>;
		private var mAnswer:String;
		private var mRequest:String;
		private var mRequestAudio:Class;
		private var mActivityWordList:Vector.<WordTemplate>;
		private var mLineBreakList:Vector.<int>;
		private var mPhylacteryArrow:Direction;
		
		public function get WordList():Vector.<String>	{ return mWordList; }
		public function get Answer():String	{ return mAnswer; }
		public function get Request():String	{ return mRequest; }
		public function get RequestAudio():Class	{ return mRequestAudio; }
		public function get ActivityWordList():Vector.<WordTemplate>	{ return mActivityWordList; }
		public function get LineBreakList():Vector.<int>	{ return mLineBreakList; }
		public function get PhylacteryArrow():Direction	{ return mPhylacteryArrow; }
		
		public function SentenceUnscramblingTemplate(aLevel:Level, aWordList:Vector.<String>, aAnswer:String, aRequest:String,
			aRequestAudio:Class, aActivityWordList:Vector.<WordTemplate>, aLineBreakList:Vector.<int> = null,
			aPhylacteryArrow:Direction = null)
		{
			super(aLevel);
			
			mStepClass = SentenceUnscrambling;
			
			mWordList = aWordList;
			mAnswer = aAnswer;
			mRequest = aRequest;
			mRequestAudio = aRequestAudio;
			mActivityWordList = aActivityWordList;
			mLineBreakList = (aLineBreakList ? aLineBreakList : new Vector.<int>());
			mPhylacteryArrow = (aPhylacteryArrow ? aPhylacteryArrow : Direction.DOWN_LEFT);
		}
	}
}