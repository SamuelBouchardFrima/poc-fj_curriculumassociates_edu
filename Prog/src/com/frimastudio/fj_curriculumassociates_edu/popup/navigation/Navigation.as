package com.frimastudio.fj_curriculumassociates_edu.popup.navigation
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.navigation.ExplorableLevel;
	import com.frimastudio.fj_curriculumassociates_edu.navigation.NavigationManager;
	import com.frimastudio.fj_curriculumassociates_edu.popup.Popup;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.sound.SoundManager;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Navigation extends Popup
	{
		private var mTemplate:NavigationTemplate;
		private var mLocationList:Vector.<CurvedBox>;
		private var mLocationContainer:Sprite;
		private var mBackground:CurvedBox;
		
		public function Navigation(aTemplate:NavigationTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			graphics.beginFill(0x000000, 0);
			graphics.drawRect(0, 0, 1024, 768);
			graphics.endFill();
			
			mBackground = new CurvedBox(new Point(600, 400), Palette.DIALOG_BOX);
			mBackground.x = 512;
			mBackground.y = 384;
			addChild(mBackground);
			
			var title:TextField = new TextField();
			title.embedFonts = true;
			title.autoSize = TextFieldAutoSize.CENTER;
			//title.text = mTemplate.Title;
			title.text = "Choose a location.";
			title.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 60, Palette.DIALOG_CONTENT,
				null, null, null, null, null, TextFormatAlign.CENTER));
			title.x = 512 - (title.width / 2);
			addChild(title);
			
			mLocationList = new Vector.<CurvedBox>();
			mLocationContainer = new Sprite();
			var location:CurvedBox;
			var offset:Number = 0;
			//for (var i:int = 0, endi:int = mTemplate.LocationList.length; i < endi; ++i)
			for (var i:int = 0, endi:int = NavigationManager.UnlockedLevelList.length; i < endi; ++i)
			{
				//location = new CurvedBox(new Point(200, 200), (mTemplate.LocationUnlockList[i] ? 0xCCFF99 : 0xCCCCCC),
				location = new CurvedBox(new Point(200, 200), 0xCCFF99,
					//new BoxLabel(mTemplate.LocationList[i], 30, Palette.DIALOG_CONTENT), 6, null, null);
					new BoxLabel(NavigationManager.UnlockedLevelList[i].Name, 30, Palette.DIALOG_CONTENT), 6);
				offset += location.width / 2;
				location.x = offset;
				location.y = 0;
				location.addEventListener(MouseEvent.CLICK, OnClickLocation);
				mLocationContainer.addChild(location);
				mLocationList.push(location);
				offset += 10 + (location.width / 2);
			}
			mLocationContainer.x = 512 - (mLocationContainer.width / 2);
			addChild(mLocationContainer);
			
			mBackground.Size = new Point(Math.max(mBackground.width, title.width, mLocationContainer.width + 20), mBackground.height);
			
			var space:Number = (mBackground.height - (title.height + mLocationContainer.height)) / 2.5;
			title.y = 384 - (mBackground.height / 2) + space;
			mLocationContainer.y = title.y + title.height + (space / 2) + (mLocationContainer.height / 2);
			
			//(new Asset.NavigationSound[0]() as Sound).play();
			SoundManager.PlayVO(Asset.NavigationSound[0]);
		}
		
		override public function Dispose():void
		{
			for (var i:int = 0, endi:int = mLocationList.length; i < endi; ++i)
			{
				mLocationList[i].removeEventListener(MouseEvent.CLICK, OnClickLocation);
			}
			
			super.Dispose();
		}
		
		override public function Refresh():void
		{
			if (mLocationList.length < NavigationManager.UnlockedLevelList.length)
			{
				var location:CurvedBox;
				var offset:Number = mLocationList[mLocationList.length - 1].x + (mLocationList[mLocationList.length - 1].width / 2) + 10;
				//for (var i:int = 0, endi:int = mTemplate.LocationList.length; i < endi; ++i)
				for (var i:int = mLocationList.length, endi:int = NavigationManager.UnlockedLevelList.length; i < endi; ++i)
				{
					//location = new CurvedBox(new Point(200, 200), (mTemplate.LocationUnlockList[i] ? 0xCCFF99 : 0xCCCCCC),
					location = new CurvedBox(new Point(200, 200), 0xCCFF99,
						//new BoxLabel(mTemplate.LocationList[i], 30, Palette.DIALOG_CONTENT), 6, null, null);
						new BoxLabel(NavigationManager.UnlockedLevelList[i].Name, 30, Palette.DIALOG_CONTENT), 6);
					offset += location.width / 2;
					location.x = offset;
					location.y = 0;
					location.addEventListener(MouseEvent.CLICK, OnClickLocation);
					mLocationContainer.addChild(location);
					mLocationList.push(location);
					offset += (location.width / 2) + 10;
				}
				mLocationContainer.x = 512 - (mLocationContainer.width / 2);
				
				mBackground.Size = new Point(Math.max(mBackground.width, mLocationContainer.width + 20), mBackground.height);
			}
			
			super.Refresh();
		}
		
		private function OnClickLocation(aEvent:MouseEvent):void
		{
			var location:CurvedBox = aEvent.currentTarget as CurvedBox;
			var level:ExplorableLevel = NavigationManager.UnlockedLevelList[mLocationList.indexOf(location)];
			
			//var vo:int = mTemplate.LocationVOList[mLocationList.indexOf(location)];
			//(new Asset.NavigationSound[vo]() as Sound).play();
			SoundManager.PlayVO(Asset.NavigationSound[level.VO]);
			
			//if (mTemplate.LocationUnlockList[mLocationList.indexOf(aEvent.currentTarget as CurvedBox)])
			//{
				//dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
			//}
			
			NavigationManager.Navigate(level);
			level.Start();
			
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}