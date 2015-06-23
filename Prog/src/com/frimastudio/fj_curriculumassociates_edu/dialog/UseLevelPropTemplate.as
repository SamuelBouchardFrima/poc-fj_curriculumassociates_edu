package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class UseLevelPropTemplate extends QuestStepTemplate
	{
		private var mActivityWordList:Vector.<WordTemplate>;
		private var mInstruction:String;
		
		public function get ActivityWordList():Vector.<WordTemplate>	{ return mActivityWordList; }
		public function get Instruction():String	{ return mInstruction; }
		
		public function UseLevelPropTemplate(aLevel:Level, aActivityWordList:Vector.<WordTemplate>, aInstruction:String)
		{
			super(aLevel);
			
			mStepClass = UseLevelProp;
			
			mActivityWordList = aActivityWordList;
			mInstruction = aInstruction;
		}
	}
}