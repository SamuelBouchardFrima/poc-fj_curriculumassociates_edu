package com.frimastudio.fj_curriculumassociates_edu.level
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.navigation.ExplorableLevel;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Level extends Sprite
	{
		private static var sI:int = 0;
		private static var sInitialized:Boolean;
		
		public static const NONE:Level = new Level(sI++, "NONE");
		public static const THE_LAB:Level = new Level(sI++, "THE_LAB", Asset.TheLabBGBitmap,
			//new Point(89, 466), 0.47111, new Point(634, 505), 0.8, //new Point(409, 466), 0.47111,
			new Point(89, 466), 0.09422, new Point(634, 505), 0.8, //new Point(409, 466), 0.47111,
			null, null, 1, Asset.ChairPropBitmap, new Point(256, 437), 0.55289);
		public static const TOWN_SQUARE:Level = new Level(sI++, "TOWN_SQUARE", Asset.TownSquareBGBitmap,
			//new Point(149, 478), 0.4, new Point(864, 535), 0.5, //new Point(700, 498), 0.4,
			new Point(149, 478), 0.08, new Point(864, 535), 0.5, //new Point(700, 498), 0.4,
			Asset.CopNPCBitmap, new Point(542, 487), 0.20667, Asset.RatPropBitmap, new Point(326, 467), 0.55556);
		public static const GROCERY_STORE:Level = new Level(sI++, "GROCERY_STORE", Asset.GroceryStoreBGBitmap,
			//new Point(149, 466), 0.35333, new Point(335, 470), 0.53333, //new Point(640, 496), 0.45333,
			new Point(149, 466), 0.07067, new Point(335, 470), 0.53333, //new Point(640, 496), 0.45333,
			Asset.ChefNPCBitmap, new Point(600, 370), 0.33333, Asset.FanPropBitmap, new Point(725, 420), 0.275);
		public static const THEATER:Level = new Level(sI++, "THEATER", Asset.TheaterBGBitmap,
			//new Point(169, 431), 0.35333, new Point(844, 460), 0.6, //new Point(429, 431), 0.35333,
			new Point(169, 431), 0.07067, new Point(844, 460), 0.6, //new Point(429, 431), 0.35333,
			//Asset.GlamStarNPCBitmap, new Point(532, 425), 0.43333, Asset.RatPropBitmap, new Point(326, 467), 0.66667, true);
			Asset.GlamStarNPCBitmap, new Point(532, 425), 0.43333, null, null, 1, true);
		
		private var mID:int;
		private var mDescription:String;
		private var mBackground:Sprite;
		private var mLucu:Sprite;
		private var mMini:Sprite;
		//private var mWildLucu:Sprite;
		private var mNPC:Sprite;
		private var mProp:Sprite;
		
		public function get ID():int	{ return mID; }
		public function get Description():String	{ return mDescription; }
		public function get Lucu():Sprite	{ return mLucu; }
		public function get Mini():Sprite	{ return mMini; }
		//public function get WildLucu():Sprite	{ return mWildLucu; }
		public function get NPC():Sprite	{ return mNPC; }
		public function get Prop():Sprite	{ return mProp; }
		
		public function get ToExplorableLevel():ExplorableLevel
		{
			switch (this)
			{
				case Level.THE_LAB:			return ExplorableLevel.THE_LAB;
				case Level.TOWN_SQUARE:		return ExplorableLevel.TOWN_SQUARE;
				case Level.GROCERY_STORE:	return ExplorableLevel.GROCERY_STORE;
				case Level.THEATER:			return ExplorableLevel.THEATER;
				default:					return ExplorableLevel.NONE;
			}
		}
		
		public function Level(aID:int, aDescription:String, aBackgroundAsset:Class = null,
			aLucuPosition:Point = null, aLucuScale:Number = 1, aMiniPosition:Point = null, aMiniScale:Number = 1,
			//aWildLucuPosition:Point = null, aWildLucuScale:Number = 1,
			aNPCAsset:Class = null, aNPCPosition:Point = null, aNPCScale:Number = 1,
			aPropAsset:Class = null, aPropPosition:Point = null, aPropScale:Number = 1, aInitialized:Boolean = false)
		{
			super();
			
			if (sInitialized)
			{
				throw new Error("Level is a multiton not intended for instantiation. Use one of its public properties.");
				return;
			}
			
			sInitialized = aInitialized;
			
			mID = aID;
			mDescription = aDescription;
			
			if (aBackgroundAsset)
			{
				mBackground = new Sprite();
				mBackground.x = 512;
				mBackground.y = 384;
				var backgroundBitmap:Bitmap = new aBackgroundAsset() as Bitmap;
				backgroundBitmap.smoothing = true;
				backgroundBitmap.x = -backgroundBitmap.width / 2;
				backgroundBitmap.y = -backgroundBitmap.height / 2;
				mBackground.addChild(backgroundBitmap);
				mBackground.width = Math.min(mBackground.width, 1024);
				mBackground.height = Math.min(mBackground.height, 768);
				mBackground.scaleX = mBackground.scaleY = Math.min(mBackground.scaleX, mBackground.scaleY);
				addChild(mBackground);
			}
			
			if (aLucuPosition)
			{
				mLucu = new Sprite();
				DisplayObjectUtil.SetPosition(mLucu, aLucuPosition);
				var lucuBitmap:Bitmap = new Asset.PloryBitmap() as Bitmap;
				lucuBitmap.smoothing = true;
				lucuBitmap.x = -lucuBitmap.width / 2;
				lucuBitmap.y = -lucuBitmap.height / 2;
				mLucu.addChild(lucuBitmap);
				mLucu.scaleX = mLucu.scaleY = aLucuScale;
				addChild(mLucu);
			}
			
			if (aMiniPosition)
			{
				mMini = new Sprite();
				DisplayObjectUtil.SetPosition(mMini, aMiniPosition);
				var miniBitmap:Bitmap = new Asset.MiniBitmap() as Bitmap;
				miniBitmap.smoothing = true;
				miniBitmap.x = -miniBitmap.width / 2;
				miniBitmap.y = -miniBitmap.height / 2;
				mMini.addChild(miniBitmap);
				mMini.scaleX = mMini.scaleY = aMiniScale;
				addChild(mMini);
			}
			
			//if (aWildLucuPosition)
			//{
				//mWildLucu = new Sprite();
				//DisplayObjectUtil.SetPosition(mWildLucu, aWildLucuPosition);
				//var wildLucuBitmap:Bitmap = new Asset.WildLucuIdleBitmap() as Bitmap;
				//wildLucuBitmap.smoothing = true;
				//wildLucuBitmap.x = -wildLucuBitmap.width / 2;
				//wildLucuBitmap.y = -wildLucuBitmap.height / 2;
				//mWildLucu.addChild(wildLucuBitmap);
				//mWildLucu.scaleX = mWildLucu.scaleY = aWildLucuScale;
				//addChild(mWildLucu);
			//}
			
			if (aNPCAsset)
			{
				if (aNPCPosition)
				{
					mNPC = new Sprite();
					DisplayObjectUtil.SetPosition(mNPC, aNPCPosition);
					var npcBitmap:Bitmap = new aNPCAsset() as Bitmap;
					npcBitmap.smoothing = true;
					npcBitmap.x = -npcBitmap.width / 2;
					npcBitmap.y = -npcBitmap.height / 2;
					mNPC.addChild(npcBitmap);
					mNPC.scaleX = mNPC.scaleY = aNPCScale;
					addChild(mNPC);
				}
				else
				{
					throw new Error("A position is required if the level has an NPC.");
				}
			}
			
			if (aPropAsset)
			{
				if (aPropPosition)
				{
					mProp = new Sprite();
					DisplayObjectUtil.SetPosition(mProp, aPropPosition);
					var propBitmap:Bitmap = new aPropAsset() as Bitmap;
					propBitmap.smoothing = true;
					propBitmap.x = -propBitmap.width / 2;
					propBitmap.y = -propBitmap.height / 2;
					mProp.addChild(propBitmap);
					mProp.scaleX = mProp.scaleY = aPropScale;
					addChild(mProp);
					
					if (this != THE_LAB && this != NONE)
					{
						mProp.addEventListener(MouseEvent.CLICK, OnClickProp);
					}
				}
				else
				{
					throw new Error("A position is required if the level has a prop.");
				}
			}
		}
		
		private function OnClickProp(aEvent:MouseEvent):void
		{
			ToExplorableLevel.ActivateLevelProp();
		}
		
		public function Reset():void
		{
			if (mBackground)
			{
				addChild(mBackground);
			}
			if (mLucu)
			{
				//TweenLite.killTweensOf(mLucu);
				//mLucu.filters = [];
				addChild(mLucu);
			}
			if (mMini)
			{
				mMini.removeChildAt(0);
				var miniBitmap:Bitmap = new Asset.MiniBitmap() as Bitmap;
				miniBitmap.smoothing = true;
				miniBitmap.x = -miniBitmap.width / 2;
				miniBitmap.y = -miniBitmap.height / 2;
				mMini.addChild(miniBitmap);
				
				//TweenLite.killTweensOf(mMini);
				//mMini.filters = [];
				addChild(mMini);
			}
			//if (mWildLucu)
			//{
				//mWildLucu.removeChildAt(0);
				//var wildLucuBitmap:Bitmap = new Asset.WildLucuIdleBitmap() as Bitmap;
				//wildLucuBitmap.smoothing = true;
				//wildLucuBitmap.x = -wildLucuBitmap.width / 2;
				//wildLucuBitmap.y = -wildLucuBitmap.height / 2;
				//mWildLucu.addChild(wildLucuBitmap);
				//
				////TweenLite.killTweensOf(mWildLucu);
				////mWildLucu.filters = [];
				//addChild(mWildLucu);
			//}
			if (mNPC)
			{
				//TweenLite.killTweensOf(mNPC);
				//mNPC.filters = [];
				addChild(mNPC);
			}
			if (mProp)
			{
				//TweenLite.killTweensOf(mProp);
				//mProp.filters = [];
				addChild(mProp);
			}
		}
	}
}