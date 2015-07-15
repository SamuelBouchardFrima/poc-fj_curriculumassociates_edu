package com.frimastudio.fj_curriculumassociates_edu.activity.wordcrafting
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	
	public class WordCraftingTemplate extends ActivityTemplate
	{
		//private var mWordList:Vector.<String>;
		//private var mAnswer:String;
		private var mEmptyWord:EmptyWordTemplate;
		private var mRequestVO:Class;
		private var mActivityWordList:Vector.<WordTemplate>;
		private var mLineBreakList:Vector.<int>;
		private var mPhylacteryArrow:Direction;
		
		//public function get WordList():Vector.<String>	{ return mWordList; }
		public function get Answer():String	{ return mEmptyWord.Answer; }
		public function get EmptyWord():EmptyWordTemplate	{ return mEmptyWord; }
		public function get RequestVO():Class	{ return mRequestVO; }
		public function get ActivityWordList():Vector.<WordTemplate>	{ return mActivityWordList; }
		public function get LineBreakList():Vector.<int>	{ return mLineBreakList; }
		public function get PhylacteryArrow():Direction	{ return mPhylacteryArrow; }
		
		//public function WordCraftingTemplate(aLevel:Level, aWordList:Vector.<String>, aAnswer:String, aRequestVO:Class,
		public function WordCraftingTemplate(aLevel:Level, aEmptyWord:EmptyWordTemplate, aRequestVO:Class,
			aActivityWordList:Vector.<WordTemplate>, aLineBreakList:Vector.<int> = null, aPhylacteryArrow:Direction = null)
		{
			super(aLevel);
			
			mStepClass = WordCrafting;
			
			//mWordList = aWordList;
			//mAnswer = aAnswer;
			mEmptyWord = aEmptyWord;
			mRequestVO = aRequestVO;
			mActivityWordList = aActivityWordList;
			mLineBreakList = (aLineBreakList ? aLineBreakList : new Vector.<int>());
			mPhylacteryArrow = (aPhylacteryArrow ? aPhylacteryArrow : Direction.DOWN_LEFT);
		}
	}
}