package com.frimastudio.fj_curriculumassociates_edu.navigation
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.poc_game.FanQuest;
	import com.frimastudio.fj_curriculumassociates_edu.poc_game.GroceryStoreQuest;
	import com.frimastudio.fj_curriculumassociates_edu.poc_game.QuestlessQuest;
	import com.frimastudio.fj_curriculumassociates_edu.poc_game.RatQuest;
	import com.frimastudio.fj_curriculumassociates_edu.poc_game.TheaterQuest;
	import com.frimastudio.fj_curriculumassociates_edu.poc_game.TheLabQuest;
	import com.frimastudio.fj_curriculumassociates_edu.poc_game.TheLabQuest2;
	import com.frimastudio.fj_curriculumassociates_edu.poc_game.TownSquareQuest;
	import com.frimastudio.fj_curriculumassociates_edu.popup.navigation.Navigation;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestEvent;
	import flash.display.Sprite;
	
	public class ExplorableLevel extends Sprite
	{
		private static var sI:int = 0;
		private static var sInitialized:Boolean = false;
		
		public static var NONE:ExplorableLevel = GenerateLevelNone();
		public static var THE_LAB:ExplorableLevel = GenerateLevelTheLab();
		public static var TOWN_SQUARE:ExplorableLevel = GenerateLevelTownSquare();
		public static var GROCERY_STORE:ExplorableLevel = GenerateLevelGroceryStore();
		public static var THEATER:ExplorableLevel = GenerateLevelTheater();
		
		private static function GenerateLevelNone():ExplorableLevel
		{
			return new ExplorableLevel(sI++, "NONE");
		}
		private static function GenerateLevelTheLab():ExplorableLevel
		{
			return new ExplorableLevel(sI++, "THE_LAB", "The Lab", Asset.NavigationTheLab, new <Class>[TheLabQuest, TheLabQuest2], 1);
		}
		private static function GenerateLevelTownSquare():ExplorableLevel
		{
			return new ExplorableLevel(sI++, "TOWN_SQUARE", "Town Square", Asset.NavigationTownSquare, new <Class>[TownSquareQuest], 2/*, RatQuest*/);
		}
		private static function GenerateLevelGroceryStore():ExplorableLevel
		{
			return new ExplorableLevel(sI++, "GROCERY_STORE", "Grocery Store", Asset.NavigationGroceryStore, new <Class>[GroceryStoreQuest], 3/*, FanQuest*/);
		}
		private static function GenerateLevelTheater():ExplorableLevel
		{
			return new ExplorableLevel(sI++, "THEATER", "Theater", Asset.NavigationTheater, new <Class>[TheaterQuest], 4, null, true);
		}
		
		private var mID:int;
		private var mDescription:String;
		private var mName:String;
		private var mNavigationAsset:Class;
		private var mQuestClassList:Vector.<Class>;
		private var mVO:int;
		private var mQuest:Quest;
		private var mSkipStep:Boolean;
		private var mLevelPropQuestClass:Class;
		private var mLevelPropQuest:Quest;
		
		public function get ID():int	{ return mID; }
		public function get Description():String	{ return mDescription; }
		public function get Name():String	{ return mName; }
		public function get NavigationAsset():Class	{ return mNavigationAsset; }
		public function get MainQuest():Quest	{ return mQuest; }
		public function get VO():int	{ return mVO; }
		
		public function get ToLevel():Level
		{
			switch (this)
			{
				case ExplorableLevel.THE_LAB:		return Level.THE_LAB;
				case ExplorableLevel.TOWN_SQUARE:	return Level.TOWN_SQUARE;
				case ExplorableLevel.GROCERY_STORE:	return Level.GROCERY_STORE;
				case ExplorableLevel.THEATER:		return Level.THEATER;
				default:							return Level.NONE;
			}
		}
		
		public function ExplorableLevel(aID:int, aDescription:String, aName:String = "", aNavigationAsset:Class = null, aQuestList:Vector.<Class> = null,
			aVO:int = -1, aLevelPropQuest:Class = null, aInitialized:Boolean = false)
		{
			if (sInitialized)
			{
				throw new Error("ExplorableLevel is a multiton not intended for instantiation. Use one of its static members.");
				return;
			}
			
			sInitialized = aInitialized;
			
			mID = aID;
			mDescription = aDescription;
			mName = aName;
			mNavigationAsset = aNavigationAsset;
			mQuestClassList = aQuestList;
			mVO = aVO;
			mLevelPropQuestClass = aLevelPropQuest;
			
			//if (aQuest)
			//{
				//mQuest = new aQuest();
				//mQuest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
				//addChild(mQuest);
			//}
		}
		
		public function Dispose():void
		{
			if (mLevelPropQuest)
			{
				mLevelPropQuest.removeEventListener(QuestEvent.COMPLETE, OnCompleteLevelPropQuest);
				mLevelPropQuest.removeEventListener(QuestEvent.OPEN_MAP, OnOpenMap);
				removeChild(mLevelPropQuest);
			}
			if (mQuest)
			{
				mQuest.removeEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
				mQuest.removeEventListener(QuestEvent.OPEN_MAP, OnOpenMap);
				mQuest.removeEventListener(QuestEvent.RESET_POC, OnResetPOC);
				if (contains(mQuest))
				{
					removeChild(mQuest);
				}
			}
		}
		
		public function Start():void
		{
			if (!mQuest)
			{
				var quest:Class = mQuestClassList.shift();
				mQuest = new quest() as Quest;
				mQuest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
				mQuest.addEventListener(QuestEvent.OPEN_MAP, OnOpenMap);
				mQuest.addEventListener(QuestEvent.RESET_POC, OnResetPOC);
				addChild(mQuest);
			}
		}
		
		public function Refresh():void
		{
			if (mQuest)
			{
				if (mSkipStep)
				{
					mQuest.SkipStep();
					mSkipStep = false;
				}
				
				//mQuest.CurrentStep.Refresh();
				mQuest.Refresh();
				//if (mQuest.CurrentStep is Navigation)
				//{
					//(mQuest.CurrentStep as Navigation).Refresh();
				//}
			}
		}
		
		public function ProgressQuest():void
		{
			mSkipStep = true;
		}
		
		public function ActivateLevelProp():void
		{
			if (mLevelPropQuest)
			{
				return;
			}
			
			if (mLevelPropQuestClass)
			{
				removeChild(mQuest);
				
				mLevelPropQuest = new mLevelPropQuestClass() as Quest;
				mLevelPropQuest.addEventListener(QuestEvent.COMPLETE, OnCompleteLevelPropQuest);
				mLevelPropQuest.addEventListener(QuestEvent.OPEN_MAP, OnOpenMap);
				addChild(mLevelPropQuest);
			}
		}
		
		private function OnCompleteLevelPropQuest(aEvent:QuestEvent):void
		{
			mLevelPropQuest.removeEventListener(QuestEvent.COMPLETE, OnCompleteLevelPropQuest);
			mLevelPropQuest.removeEventListener(QuestEvent.OPEN_MAP, OnOpenMap);
			removeChild(mLevelPropQuest);
			mLevelPropQuest = null;
			mLevelPropQuestClass = null;
			
			addChild(mQuest);
			mQuest.Refresh();
		}
		
		private function OnCompleteQuest(aEvent:QuestEvent):void
		{
			mQuest.removeEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			mQuest.removeEventListener(QuestEvent.OPEN_MAP, OnOpenMap);
			mQuest.removeEventListener(QuestEvent.RESET_POC, OnResetPOC);
			removeChild(mQuest);
			
			if (mQuestClassList.length)
			{
				var quest:Class = mQuestClassList.shift();
				mQuest = new quest() as Quest;
				mQuest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			}
			else
			{
				mQuest = new QuestlessQuest(this);
			}
			
			mQuest.addEventListener(QuestEvent.OPEN_MAP, OnOpenMap);
			mQuest.addEventListener(QuestEvent.RESET_POC, OnResetPOC);
			addChild(mQuest);
			
			// TODO:	highlight map button
			// TODO:	display bubble that says "Tap the map."
			//OpenMap();
			
			//Inventory.Reset();
			//
			//var newQuest:GamePOCQuest = new GamePOCQuest();
			//newQuest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			//addChildAt(newQuest, getChildIndex(quest));
			//
			//removeChild(quest);
		}
		
		private function OnOpenMap(aEvent:QuestEvent):void
		{
			OpenMap();
		}
		
		private function OpenMap():void
		{
			if (mLevelPropQuest)
			{
				removeChild(mLevelPropQuest);
			}
			else
			{
				removeChild(mQuest);
			}
			
			var navigationQuest:NavigationQuest = new NavigationQuest(this);
			navigationQuest.addEventListener(QuestEvent.COMPLETE, OnCompleteNavigation);
			addChild(navigationQuest);
		}
		
		private function OnCompleteNavigation(aEvent:QuestEvent):void
		{
			var navigationQuest:NavigationQuest = aEvent.currentTarget as NavigationQuest;
			navigationQuest.removeEventListener(QuestEvent.COMPLETE, OnCompleteNavigation);
			removeChild(navigationQuest);
			
			if (mLevelPropQuest)
			{
				addChild(mLevelPropQuest);
				//mLevelPropQuest.Refresh();
			}
			else
			{
				addChild(mQuest);
				//mQuest.Refresh();
			}
		}
		
		private function OnResetPOC(aEvent:QuestEvent):void
		{
			sI = 0;
			sInitialized = false;
			
			NONE.Dispose();
			THE_LAB.Dispose();
			TOWN_SQUARE.Dispose();
			GROCERY_STORE.Dispose();
			THEATER.Dispose();
			
			NONE = GenerateLevelNone();
			THE_LAB = GenerateLevelTheLab();
			TOWN_SQUARE = GenerateLevelTownSquare();
			GROCERY_STORE = GenerateLevelGroceryStore();
			THEATER = GenerateLevelTheater();
			
			Inventory.Reset();
			
			NavigationManager.Reset();
			NavigationManager.Navigate(ExplorableLevel.THE_LAB);
			THE_LAB.Start();
		}
	}
}