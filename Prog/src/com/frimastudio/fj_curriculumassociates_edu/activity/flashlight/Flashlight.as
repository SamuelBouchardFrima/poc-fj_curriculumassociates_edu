package com.frimastudio.fj_curriculumassociates_edu.activity.flashlight
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.Activity;
	
	public class Flashlight extends Activity
	{
		private var mTemplate:FlashlightTemplate;
		
		public function Flashlight(aTemplate:FlashlightTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
		}
	}
}