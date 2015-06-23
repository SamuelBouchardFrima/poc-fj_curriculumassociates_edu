package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class UseItemTemplate extends QuestStepTemplate
	{
		private var mInstruction:String;
		private var mItemAsset:Class;
		
		public function get Instruction():String	{ return mInstruction; }
		public function get ItemAsset():Class	{ return mItemAsset; }
		
		public function UseItemTemplate(aLevel:Level, aInstruction:String, aItemAsset:Class)
		{
			super(aLevel);
			
			mStepClass = UseItem;
			
			mInstruction = aInstruction;
			mItemAsset = aItemAsset;
		}
	}
}