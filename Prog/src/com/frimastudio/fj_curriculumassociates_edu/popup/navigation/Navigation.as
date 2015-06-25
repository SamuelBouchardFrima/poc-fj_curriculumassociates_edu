package com.frimastudio.fj_curriculumassociates_edu.popup.navigation
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.popup.Popup;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Navigation extends Popup
	{
		private var mTemplate:NavigationTemplate;
		private var mLocationList:Vector.<CurvedBox>;
		
		public function Navigation(aTemplate:NavigationTemplate)
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
			title.autoSize = TextFieldAutoSize.CENTER;
			title.text = mTemplate.Title;
			title.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 60, Palette.DIALOG_CONTENT,
				null, null, null, null, null, TextFormatAlign.CENTER));
			title.x = 512 - (title.width / 2);
			addChild(title);
			
			mLocationList = new Vector.<CurvedBox>();
			var locationContainer:Sprite = new Sprite();
			var location:CurvedBox;
			var offset:Number = 0;
			for (var i:int = 0, endi:int = mTemplate.LocationList.length; i < endi; ++i)
			{
				location = new CurvedBox(new Point(200, 200), (mTemplate.LocationUnlockList[i] ? 0xCCFF99 : 0xCCCCCC),
					new BoxLabel(mTemplate.LocationList[i], 30, Palette.DIALOG_CONTENT), 12, null, null);
				offset += location.width / 2;
				location.x = offset;
				location.y = 0;
				location.addEventListener(MouseEvent.CLICK, OnClickLocation);
				locationContainer.addChild(location);
				mLocationList.push(location);
				offset += 10 + (location.width / 2);
			}
			locationContainer.x = 512 - (locationContainer.width / 2);
			addChild(locationContainer);
			
			background.Size = new Point(Math.max(background.width, title.width, locationContainer.width + 20), background.height);
			
			var space:Number = (background.height - (title.height + locationContainer.height)) / 2.5;
			title.y = 384 - (background.height / 2) + space;
			locationContainer.y = title.y + title.height + (space / 2) + (locationContainer.height / 2);
		}
		
		override public function Dispose():void
		{
			for (var i:int = 0, endi:int = mLocationList.length; i < endi; ++i)
			{
				mLocationList[i].removeEventListener(MouseEvent.CLICK, OnClickLocation);
			}
			
			super.Dispose();
		}
		
		private function OnClickLocation(aEvent:MouseEvent):void
		{
			if (mTemplate.LocationUnlockList[mLocationList.indexOf(aEvent.currentTarget as CurvedBox)])
			{
				dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
			}
		}
	}
}