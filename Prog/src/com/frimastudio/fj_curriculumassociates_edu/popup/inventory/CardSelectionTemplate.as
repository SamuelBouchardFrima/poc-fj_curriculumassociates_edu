package com.frimastudio.fj_curriculumassociates_edu.popup.inventory
{
	import com.frimastudio.fj_curriculumassociates_edu.inventory.CardType;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.popup.PopupTemplate;
	
	public class CardSelectionTemplate extends PopupTemplate
	{
		private var mType:CardType;
		private var mSlot:int;
		
		public function get Type():CardType	{ return mType; }
		public function get Slot():int	{ return mSlot; }
		
		public function CardSelectionTemplate(aLevel:Level, aType:CardType, aSlot:int)
		{
			super(aLevel);
			
			mStepClass = CardSelection;
			
			mType = aType;
			mSlot = aSlot;
		}
	}
}