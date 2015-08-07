package com.frimastudio.fj_curriculumassociates_edu.popup.reward
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.popup.Popup;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.sound.SoundManager;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	public class Reward extends Popup
	{
		private var mTemplate:RewardTemplate;
		private var mCurrentReward:int;
		private var mPlayRewardTypeTimer:Timer;
		private var mPlayNextRewardTimer:Timer;
		
		public function Reward(aTemplate:RewardTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			graphics.beginFill(0x000000, 0);
			graphics.drawRect(0, 0, 1024, 768);
			graphics.endFill();
			
			var background:CurvedBox = new CurvedBox(new Point(600, 400), Palette.DIALOG_BOX);
			background.x = 512;
			background.y = 384;
			addChild(background);
			
			var title:TextField = new TextField();
			title.embedFonts = true;
			title.selectable = false;
			title.autoSize = TextFieldAutoSize.CENTER;
			title.text = mTemplate.Title;
			title.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 60, Palette.DIALOG_CONTENT,
				null, null, null, null, null, TextFormatAlign.CENTER));
			title.x = 512 - (title.width / 2);
			addChild(title);
			
			background.Size = new Point(Math.max(background.width, title.width), background.height);
			
			var body:TextField = new TextField();
			body.embedFonts = true;
			body.selectable = false;
			body.width = background.width;
			body.wordWrap = true;
			body.multiline = true;
			body.autoSize = TextFieldAutoSize.CENTER;
			switch (mTemplate.Type)
			{
				case RewardType.WORD:
					body.text = "Words:";
					break;
				case RewardType.LETTER_PATTERN_CARD:
					body.text = "Letter Pattern Cards:";
					break;
				default:
					throw new Error("Reward type " + mTemplate.Type.Description + " not handled.");
					break;
			}
			body.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 48, Palette.DIALOG_CONTENT,
				null, null, null, null, null, TextFormatAlign.CENTER));
			body.x = 512 - (body.width / 2);
			addChild(body);
			
			var rewardContainer:Sprite = new Sprite();
			var reward:CurvedBox;
			var rewardColor:int = 0x000000;
			switch (mTemplate.Type)
			{
				case RewardType.WORD:
					rewardColor = 0xCCCCCC;
					break;
				case RewardType.LETTER_PATTERN_CARD:
					rewardColor = 0xCC99FF;
					break;
				default:
					throw new Error("Reward type " + mTemplate.Type.Description + " not handled.");
					break;
			}
			var offset:Number = 0;
			for (var i:int = 0, endi:int = mTemplate.RewardList.length; i < endi; ++i)
			{
				reward = new CurvedBox(new Point(60, 60), rewardColor,
					new BoxLabel(mTemplate.RewardList[i], 45, Palette.DIALOG_CONTENT), 6, null, Axis.HORIZONTAL);
				reward.ColorBorderOnly = true;
				offset += reward.width / 2;
				reward.x = offset;
				reward.y = 0;
				offset += 10 + (reward.width / 2);
				rewardContainer.addChild(reward);
			}
			rewardContainer.x = 512 - (rewardContainer.width / 2);
			addChild(rewardContainer);
			
			var space:Number = (background.height - (title.height + body.height + rewardContainer.y)) / 3;
			title.y = 384 - (background.height / 2) + space;
			body.y = title.y + title.height;
			rewardContainer.y = body.y + body.height + (space / 2);
			
			//var sound:Sound = new mTemplate.TitleVO() as Sound;
			//sound.play();
			var soundLength:Number = SoundManager.PlayVO(mTemplate.TitleVO);
			
			mPlayRewardTypeTimer = new Timer(soundLength, 1);
			mPlayRewardTypeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnPlayRewardTypeTimerComplete);
			mPlayRewardTypeTimer.start();
			
			addEventListener(MouseEvent.CLICK, OnClick);
		}
		
		override public function Dispose():void
		{
			mPlayRewardTypeTimer.reset();
			mPlayRewardTypeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnPlayRewardTypeTimerComplete);
			
			if (mPlayNextRewardTimer)
			{
				mPlayNextRewardTimer.reset();
				mPlayNextRewardTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnPlayNextRewardTimerComplete);
			}
			
			removeEventListener(MouseEvent.CLICK, OnClick);
			
			super.Dispose();
		}
		
		private function OnPlayRewardTypeTimerComplete(aEvent:TimerEvent):void
		{
			mPlayRewardTypeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnPlayRewardTypeTimerComplete);
			
			//var sound:Sound;
			var sound:Class;
			switch (mTemplate.Type)
			{
				case RewardType.WORD:
					//sound = new Asset.RewardSound[5]() as Sound;
					sound = Asset.RewardSound[5];
					break;
				case RewardType.LETTER_PATTERN_CARD:
					//sound = new Asset.RewardSound[4]() as Sound;
					sound = Asset.RewardSound[4];
					break;
				default:
					throw new Error("Reward type " + mTemplate.Type.Description + " not handled.");
					break;
			}
			
			if (sound)
			{
				//sound.play();
				var soundLength:Number = SoundManager.PlayVO(sound);
				
				mPlayNextRewardTimer = new Timer(soundLength, 1);
			}
			else
			{
				mPlayNextRewardTimer = new Timer(300, 1);
			}
			
			mCurrentReward = 0;
			
			mPlayNextRewardTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnPlayNextRewardTimerComplete);
			mPlayNextRewardTimer.start();
		}
		
		private function OnPlayNextRewardTimerComplete(aEvent:TimerEvent):void
		{
			mPlayNextRewardTimer.reset();
			
			if (mCurrentReward < mTemplate.RewardList.length)
			{
				//var sound:Sound;
				var sound:Class;
				if (Asset.NewChunkSound["_" + mTemplate.RewardList[mCurrentReward]])
				{
					//sound = new Asset.NewChunkSound["_" + mTemplate.RewardList[mCurrentReward]]() as Sound;
					sound = Asset.NewChunkSound["_" + mTemplate.RewardList[mCurrentReward]];
				}
				else if (Asset.WordContentSound["_" + mTemplate.RewardList[mCurrentReward]])
				{
					//sound = new Asset.WordContentSound["_" + mTemplate.RewardList[mCurrentReward]]() as Sound;
					sound = Asset.WordContentSound["_" + mTemplate.RewardList[mCurrentReward]];
				}
				else if (Asset.NewWordSound["_" + mTemplate.RewardList[mCurrentReward]])
				{
					//sound = new Asset.NewWordSound["_" + mTemplate.RewardList[mCurrentReward]]() as Sound;
					sound = Asset.NewWordSound["_" + mTemplate.RewardList[mCurrentReward]];
				}
				else
				{
					trace("Warning: sound " + mTemplate.RewardList[mCurrentReward] + " could not be found.");
				}
				
				if (sound)
				{
					//sound.play();
					//var soundLength:Number = SoundManager.PlayVO(sound);
					var soundLength:Number = SoundManager.PlaySFX(sound);
					
					mPlayNextRewardTimer.delay = soundLength;
				}
				else
				{
					mPlayNextRewardTimer.delay = 300;
				}
				
				++mCurrentReward;
				
				mPlayNextRewardTimer.start();
			}
			else
			{
				mPlayNextRewardTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnPlayNextRewardTimerComplete);
			}
		}
		
		private function OnClick(aEvent:MouseEvent):void
		{
			var i:int, endi:int;
			switch (mTemplate.Type)
			{
				case RewardType.WORD:
					for (i = 0, endi = mTemplate.RewardList.length; i < endi; ++i)
					{
						Inventory.AddWord(mTemplate.RewardList[i]);
					}
					break;
				case RewardType.LETTER_PATTERN_CARD:
					for (i = 0, endi = mTemplate.RewardList.length; i < endi; ++i)
					{
						Inventory.AddLetterPatternCard(mTemplate.RewardList[i]);
					}
					break;
				default:
					break;
			}
			
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}