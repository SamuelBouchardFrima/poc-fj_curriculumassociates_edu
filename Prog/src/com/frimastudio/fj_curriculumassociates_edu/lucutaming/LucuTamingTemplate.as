package com.frimastudio.fj_curriculumassociates_edu.lucutaming
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	
	public class LucuTamingTemplate extends ActivityTemplate
	{
		private var mCurrentLevel:Level;
		
		public function get CurrentLevel():Level	{ return mCurrentLevel; }
		
		public function LucuTamingTemplate(aLevel:Level)
		{
			super(null);
			
			mStepClass = LucuTaming;
			
			mCurrentLevel = aLevel;
		}
	}
}