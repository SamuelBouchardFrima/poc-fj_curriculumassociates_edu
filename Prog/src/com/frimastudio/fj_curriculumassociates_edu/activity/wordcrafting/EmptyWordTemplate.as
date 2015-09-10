package com.frimastudio.fj_curriculumassociates_edu.activity.wordcrafting
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityWordTemplate;
	
	public class EmptyWordTemplate extends ActivityWordTemplate
	{
		private var mAnswer:String;
		
		public function get Answer():String	{ return mAnswer; }
		
		public function EmptyWordTemplate(aWord:String, aPunctuation:String = "")
		{
			var emptyWord:String = "";
			for (var i:int = 0, endi:int = aWord.length; i < endi; ++i)
			{
				emptyWord += "_";
			}
			
			super(emptyWord, aPunctuation, ActivityType.WORD_CRAFTING);
			
			mAnswer = aWord;
			mVO = mAnswer;
		}
	}
}