package com.frimastudio.fj_curriculumassociates_edu.lucutaming
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.inventory.CardType;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.popup.inventory.CardSelectionTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.reward.RewardTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.reward.RewardType;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class LucuTamingQuest extends Quest
	{
		public function LucuTamingQuest(aLevel:Level)
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new CardSelectionTemplate(null, CardType.LETTER_PATTERN, 3));
			mStepList.push(new LucuTamingTemplate(aLevel));
			mStepList.push(new RewardTemplate(null, "WILD LUCU CHALLENGE REWARD", Asset.RewardSound[2], RewardType.WORD,
				new <String>[/*WordList*/]));
			
			super();
			
			var data:BitmapData = new BitmapData(1024, 768, false, 0x000000);
			data.draw(aLevel);
			var levelBitmap:Bitmap = new Bitmap(data, "auto", true);
			addChildAt(levelBitmap, 0);
		}
		
		override protected function CompleteQuest():void
		{
			super.CompleteQuest();
		}
	}
}