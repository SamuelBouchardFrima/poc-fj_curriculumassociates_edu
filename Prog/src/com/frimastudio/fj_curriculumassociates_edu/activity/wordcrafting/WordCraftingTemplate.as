package com.frimastudio.fj_curriculumassociates_edu.activity.wordcrafting
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	
	public class WordCraftingTemplate extends ActivityTemplate
	{
		private var mWordList:Vector.<String>;
		private var mAnswer:String;
		private var mActivityWordList:Vector.<WordTemplate>;
		
		public function get WordList():Vector.<String>	{ return mWordList; }
		public function get Answer():String	{ return mAnswer; }
		public function get ActivityWordList():Vector.<WordTemplate>	{ return mActivityWordList; }
		
		public function WordCraftingTemplate(aLevel:Level, aWordList:Vector.<String>, aAnswer:String,
			aActivityWordList:Vector.<WordTemplate>)
		{
			super(aLevel);
			
			mStepClass = WordCrafting;
			
			mWordList = aWordList;
			mAnswer = aAnswer;
			mActivityWordList = aActivityWordList;
		}
	}
}