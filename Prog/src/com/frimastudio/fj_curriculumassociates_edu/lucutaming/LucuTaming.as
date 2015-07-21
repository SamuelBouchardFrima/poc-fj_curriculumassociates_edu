package com.frimastudio.fj_curriculumassociates_edu.lucutaming
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.Activity;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityBox;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.sound.SoundManager;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxIcon;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.Piece;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTray;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTrayEvent;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.MathUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	public class LucuTaming extends Activity
	{
		private var mTemplate:LucuTamingTemplate;
		private var mToolTrayBox:Box;
		private var mDialogBox:CurvedBox;
		private var mActivityBox:ActivityBox;
		private var mBurpTimer:Timer;
		private var mWildLucu:Sprite;
		private var mMouthPosition:Point;
		private var mFloatPieceList:Vector.<Piece>;
		private var mFloatPieceArea:Rectangle;
		private var mCraftingTray:PieceTray;
		private var mToolTray:PieceTray;
		
		public function LucuTaming(aTemplate:LucuTamingTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			mWildLucu = new Sprite();
			mWildLucu.scaleX = mWildLucu.scaleY = mTemplate.CurrentLevel.WildLucu.scaleX;
			DisplayObjectUtil.SetPosition(mWildLucu, DisplayObjectUtil.GetPosition(mTemplate.CurrentLevel.WildLucu));
			addChild(mWildLucu);
			SetWildLucu(Asset.WildLucuIdleBitmap);
			
			mMouthPosition = DisplayObjectUtil.GetPosition(mWildLucu).add(new Point(10, -5));
			
			mToolTrayBox = new Box(new Point(1024, 130), Palette.TOOL_BOX);
			mToolTrayBox.x = 512;
			mToolTrayBox.y = 838;
			addChild(mToolTrayBox);
			TweenLite.to(mToolTrayBox, 1.2, { ease:Elastic.easeOut, y:753 });
			
			var playerPortrait:Sprite = new Sprite();
			var playerPortraitBitmap:Bitmap = new Asset.PlayerPortrait() as Bitmap;
			playerPortraitBitmap.smoothing = true;
			playerPortraitBitmap.scaleX = playerPortraitBitmap.scaleY = 0.75;
			playerPortraitBitmap.x = -playerPortraitBitmap.width / 2;
			playerPortraitBitmap.y = -playerPortraitBitmap.height / 2;
			playerPortrait.addChild(playerPortraitBitmap);
			playerPortrait.x = 5 + (playerPortrait.width / 2);
			playerPortrait.y = 763 - (playerPortrait.height / 2);
			addChild(playerPortrait);
			
			mToolTray = new PieceTray(false, new < String > ["___", "___", "___"]);
			mToolTray.BoxColor = 0xD18B25;
			mToolTray.x = playerPortrait.x + (playerPortrait.width / 2) + 15;
			mToolTray.y = 813;
			//mToolTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedToolTray);
			addChild(mToolTray);
			TweenLite.to(mToolTray, 1.2, { ease:Elastic.easeOut, delay:0.1, y:728 });
			
			mWildLucuChallengeBtn = new CurvedBox(new Point(64, 64), 0xD18B25,
				new BoxIcon(Asset.WildLucuIdleBitmap, Palette.BTN_CONTENT), 6);
			mWildLucuChallengeBtn.x = 1014 - (mWildLucuChallengeBtn.width / 2);
			mWildLucuChallengeBtn.y = 758 - (mWildLucuChallengeBtn.height / 2);
			addChild(mWildLucuChallengeBtn);
			
			mDialogBox = new CurvedBox(new Point(800, 60), Palette.DIALOG_BOX,
				new BoxLabel("Craft the requested words as fast as you can.", 45, Palette.DIALOG_CONTENT), 6,
				Direction.UP_LEFT, Axis.BOTH);
			mDialogBox.x = mTemplate.CurrentLevel.Lucu.x - (mTemplate.CurrentLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = Math.min(mTemplate.CurrentLevel.Lucu.y + (mTemplate.CurrentLevel.Lucu.height / 2) + 10 +
				(mDialogBox.height / 2), 668 - (mDialogBox.height / 2));
			addChild(mDialogBox);
			
			mActivityBox = new ActivityBox(new Vector.<WordTemplate>(), new Vector.<int>(), null, null);
			mActivityBox.x = 512;
			mActivityBox.y = 70;
			addChild(mActivityBox);
			
			mCraftingTray = new PieceTray(false, new <String>["___"]);
			mCraftingTray.BoxColor = ActivityType.WORD_CRAFTING.ColorCode;
			mCraftingTray.x = 40;
			mCraftingTray.y = 70;
			//mCraftingTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedCraftingTray);
			addChild(mCraftingTray);
			
			var openMouthTimer:Timer = new Timer(100, 1);
			openMouthTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnOpenMouthTimerComplete);
			openMouthTimer.start();
			
			var card:CurvedBox;
			for (var i:int = 0, endi:int = Inventory.SelectedLetterPatternCardList.length; i < endi; ++i)
			{
				card = new CurvedBox(new Point(64, 64), 0xCC99FF,
					new BoxLabel(Inventory.SelectedLetterPatternCardList[i], 48, Palette.DIALOG_CONTENT), 6, null, Axis.HORIZONTAL);
				card.ColorBorderOnly = true;
				DisplayObjectUtil.SetPosition(card, DisplayObjectUtil.GetPosition(playerPortrait));
				card.alpha = 0;
				card.scaleX = card.scaleY = 0.01;
				addChild(card);
				TweenLite.to(card, 0.2, { ease:Strong.easeOut, delay:(i * 0.8), alpha:1, scaleX:1, scaleY:1 });
				TweenLite.to(card, 0.8, { ease:Elastic.easeOut, delay:((i * 0.8) + 0.2),
					onComplete:OnTweenSendCard, onCompleteParams:[card], x:mMouthPosition.x, y:mMouthPosition.y });
			}
			
			var swallowDuration:Number = ((Inventory.SelectedLetterPatternCardList.length * 0.8) + 0.5) * 1000;
			
			var closeMouthTimer:Timer = new Timer(swallowDuration, 1);
			closeMouthTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCloseMouthTimerComplete);
			closeMouthTimer.start();
			
			var startBurpTimerTimer:Timer = new Timer(swallowDuration + 800, 1);
			startBurpTimerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnStartBurpTimerTimerComplete);
			startBurpTimerTimer.start();
			
			mBurpTimer = new Timer(5000, 5);
			mBurpTimer.addEventListener(TimerEvent.TIMER, OnBurpTimer);
			mBurpTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnBurpTimerComplete);
			
			mFloatPieceList = new Vector.<Piece>();
			
			var areaY:Number = 180;
			var areaH:Number = 300;
			mFloatPieceArea = new Rectangle(100, areaY, 824, areaH);
			
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
		}
		
		override public function Dispose():void
		{
			removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
			
			mActivityBox.Dispose();
			
			mBurpTimer.removeEventListener(TimerEvent.TIMER, OnBurpTimer);
			mBurpTimer.reset();
			
			super.Dispose();
		}
		
		private function SetWildLucu(aWildLucuAsset:Class):void
		{
			while (mWildLucu.numChildren)
			{
				mWildLucu.removeChildAt(0);
			}
			
			var wildLucuBitmap:Bitmap = new aWildLucuAsset() as Bitmap;
			wildLucuBitmap.smoothing = true;
			wildLucuBitmap.x = -wildLucuBitmap.width / 2;
			wildLucuBitmap.y = -wildLucuBitmap.height / 2;
			mWildLucu.addChild(wildLucuBitmap);
		}
		
		private function OnEnterFrame(aEvent:Event):void
		{
			var i:int, endi:int, iTarget:Point;
			var j:int, endj:int, jTarget:Point;
			var distance:Point;
			for (i = 0, endi = mFloatPieceList.length; i < endi; ++i)
			{
				for (j = 0, endj = mFloatPieceList.length; j < endj; ++j)
				{
					if (j != i)
					{
						distance = DisplayObjectUtil.GetPosition(mFloatPieceList[j]);
						distance = distance.subtract(DisplayObjectUtil.GetPosition(mFloatPieceList[i]));
						if (distance.length <= (mFloatPieceList[j].width / 2) + (mFloatPieceList[i].width / 2))
						{
							distance.normalize(distance.length / 2);
							
							jTarget = DisplayObjectUtil.GetPosition(mFloatPieceList[j]).add(distance);
							jTarget = MathUtil.MinMaxPoint(jTarget, mFloatPieceArea);
							TweenLite.to(mFloatPieceList[j], 2, { ease:Quad.easeOut, overwrite:false,
								x:jTarget.x, y:jTarget.y });
							
							iTarget = DisplayObjectUtil.GetPosition(mFloatPieceList[i]).subtract(distance);
							iTarget = MathUtil.MinMaxPoint(iTarget, mFloatPieceArea);
							TweenLite.to(mFloatPieceList[i], 2, { ease:Quad.easeOut, overwrite:false,
								x:iTarget.x, y:iTarget.y });
						}
					}
				}
			}
		}
		
		private function OnOpenMouthTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnOpenMouthTimerComplete);
			
			SetWildLucu(Asset.WildLucuOpenBitmap);
		}
		
		private function OnTweenSendCard(aCard:CurvedBox):void
		{
			TweenLite.to(aCard, 0.4, { ease:Strong.easeOut, onComplete:OnTweenEatCard, onCompleteParams:[aCard],
				alpha:0, scaleX:0.1, scaleY:0.1 });
		}
		
		private function OnTweenEatCard(aCard:CurvedBox):void
		{
			removeChild(aCard);
		}
		
		private function OnStartBurpTimerTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnStartBurpTimerTimerComplete);
			
			OnBurpTimer(null);
			mBurpTimer.start();
		}
		
		private function OnBurpTimer(aEvent:TimerEvent):void
		{
			var soundLength:Number = SoundManager.PlaySFX(Asset.BurpSound);
			
			SetWildLucu(Asset.WildLucuBurpBitmap);
			
			var closeMouthTimer:Timer = new Timer(soundLength, 1);
			closeMouthTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCloseMouthTimerComplete);
			closeMouthTimer.start();
			
			// burp batch of letters
			var piece:Piece;
			var bubble:Bitmap;
			var target:Point;
			for (var i:int = 0, endi:int = 4; i < endi; ++i)
			{
				piece = new Piece(null, null, "_", mMouthPosition, ActivityType.WORD_CRAFTING.ColorCode);
				DisplayObjectUtil.SetPosition(piece, mMouthPosition);
				//piece.alpha = 0;
				piece.scaleX = piece.scaleY = 0.01;
				bubble = new Asset.BubbleBitmap();
				bubble.smoothing = true;
				bubble.width = Math.max(bubble.width, piece.width + 30);
				bubble.scaleY = bubble.scaleX;
				bubble.x = -bubble.width / 2;
				bubble.y = -bubble.height / 2;
				piece.addChild(bubble);
				piece.addEventListener(MouseEvent.CLICK, OnClickFloatPiece);
				addChild(piece);
				target = Random.Position2D(mFloatPieceArea);
				TweenLite.to(piece, 2, { ease:Quad.easeOut, delay:(i * 0.1), x:target.x, y:target.y });
				TweenLite.to(piece, 1, { ease:Elastic.easeOut, delay:(i * 0.1), alpha:1, scaleX:1, scaleY:1 });
				
				mFloatPieceList.push(piece);
			}
		}
		
		private function OnCloseMouthTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnCloseMouthTimerComplete);
			
			SetWildLucu(Asset.WildLucuIdleBitmap);
		}
		
		private function OnClickFloatPiece(aEvent:MouseEvent):void
		{
			var piece:Piece = aEvent.currentTarget as Piece;
			piece.removeEventListener(MouseEvent.CLICK, OnClickFloatPiece);
			
			piece.removeChildAt(piece.numChildren - 1);
			var bubbleSplash:Bitmap = new Asset.BubbleSplashBitmap();
			bubbleSplash.x = piece.x - (bubbleSplash.width / 2);
			bubbleSplash.y = piece.y - (bubbleSplash.height / 2);
			addChild(bubbleSplash);
			TweenLite.to(bubbleSplash, 1, { ease:Strong.easeOut, onComplete:OnTweenHideBubbleSplash,
				onCompleteParams:[bubbleSplash], alpha:0 });
		}
		
		private function OnTweenHideBubbleSplash(aBubbleSplash:Bitmap):void
		{
			removeChild(aBubbleSplash);
		}
		
		private function OnBurpTimerComplete(aEvent:TimerEvent):void
		{
			var vacuumTimer:Timer = new Timer(30000, 1);
			vacuumTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnVacuumTimerComplete);
			vacuumTimer.start();
		}
		
		private function OnVacuumTimerComplete(aEvent:TimerEvent):void
		{
			if (true/*remaining letters*/)
			{
				// vacuum sound
				
				SetWildLucu(Asset.WildLucuVacuumBitmap);
				
				removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
				
				var distance:Number;
				var target:Point = mMouthPosition.add(new Point(15, -10));
				for (var i:int = 0, endi:int = mFloatPieceList.length; i < endi; ++i)
				{
					distance = target.subtract(DisplayObjectUtil.GetPosition(mFloatPieceList[i])).length;
					mFloatPieceList[i].removeEventListener(MouseEvent.CLICK, OnClickFloatPiece);
					TweenLite.to(mFloatPieceList[i], 2, { ease:Strong.easeIn, delay:(distance / 400),
						onComplete:OnTweenVacuumFloatPiece, onCompleteParams:[mFloatPieceList[i]],
						x:target.x, y:target.y });
				}
			}
		}
		
		private function OnTweenVacuumFloatPiece(aPiece:Piece):void
		{
			TweenLite.to(aPiece, 0.4, { ease:Strong.easeOut, onComplete:OnTweenSwallowFloatPiece,
				onCompleteParams:[aPiece], alpha:0, scaleX:0.01, scaleY:0.01 });
		}
		
		private function OnTweenSwallowFloatPiece(aPiece:Piece):void
		{
			removeChild(aPiece);
			mFloatPieceList.splice(mFloatPieceList.indexOf(aPiece), 1);
			
			if (!mFloatPieceList.length)
			{
				var closeMouthTimer:Timer = new Timer(300, 1);
				closeMouthTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCloseMouthTimerComplete);
				closeMouthTimer.start();
			}
		}
	}
}