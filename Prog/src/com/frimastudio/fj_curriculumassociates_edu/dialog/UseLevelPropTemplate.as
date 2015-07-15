package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	
	public class UseLevelPropTemplate extends QuestStepTemplate
	{
		private var mInstruction:String;
		private var mInstructionVO:Class;
		private var mActivityWordList:Vector.<WordTemplate>;
		private var mLineBreakList:Vector.<int>;
		private var mPhylacteryArrow:Direction;
		
		public function get Instruction():String	{ return mInstruction; }
		public function get InstructionVO():Class	{ return mInstructionVO; }
		public function get ActivityWordList():Vector.<WordTemplate>	{ return mActivityWordList; }
		public function get LineBreakList():Vector.<int>	{ return mLineBreakList; }
		public function get PhylacteryArrow():Direction	{ return mPhylacteryArrow; }
		
		public function UseLevelPropTemplate(aLevel:Level, aInstruction:String, aInstructionVO:Class,
			aActivityWordList:Vector.<WordTemplate>, aLineBreakList:Vector.<int> = null, aPhylacteryArrow:Direction = null)
		{
			super(aLevel);
			
			mStepClass = UseLevelProp;
			
			mInstruction = aInstruction;
			mInstructionVO = aInstructionVO;
			mActivityWordList = aActivityWordList;
			mLineBreakList = (aLineBreakList ? aLineBreakList : new Vector.<int>());
			mPhylacteryArrow = (aPhylacteryArrow ? aPhylacteryArrow : Direction.DOWN_LEFT);
		}
	}
}