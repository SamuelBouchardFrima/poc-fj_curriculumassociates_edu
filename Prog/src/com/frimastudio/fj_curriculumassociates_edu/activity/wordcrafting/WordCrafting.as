package com.frimastudio.fj_curriculumassociates_edu.activity.wordcrafting
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.Activity;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityBox;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.activity.Result;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dictionary.WordDictionary;
	import com.frimastudio.fj_curriculumassociates_edu.FontList;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxIcon;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.Piece;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTray;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTrayEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.UIButton;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Geometry;
	import com.frimastudio.fj_curriculumassociates_edu.util.MathUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.MouseUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	public class WordCrafting extends Activity
	{
		private var mTemplate:WordCraftingTemplate;
		private var mCraftingTrayField:CurvedBox;
		private var mToolTray:PieceTray;
		private var mCraftingTray:PieceTray;
		private var mSubmitBtn:CurvedBox;
		private var mPreviousPosition:Piece;
		private var mDraggedPiece:Piece;
		private var mLearnedWordList:Object;
		//private var mSubmitedWord:UIButton;
		private var mSubmitedWord:Sprite;
		private var mSubmissionHighlight:Sprite;
		private var mAnswer:String;
		private var mResult:Result;
		private var mBlocker:Sprite;
		private var mSuccessFeedback:Sprite;
		private var mFloatPieceList:Vector.<Piece>;
		private var mFloatPieceArea:Rectangle;
		private var mDragAutostartTimer:Timer;
		private var mMouseDownOrigin:Point;
		private var mTutorialStep:int;
		private var mTutorialTimer:Timer;
		private var mMiniDefaultPosition:Point;
		private var mMiniDefaultScale:Number;
		private var mDialogBox:CurvedBox;
		private var mActivityBox:ActivityBox;
		private var mStoredCraftingTrayChunkList:Vector.<String>;
		
		public function WordCrafting(aTemplate:WordCraftingTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			mMiniDefaultPosition = DisplayObjectUtil.GetPosition(mLevel.Mini);
			mMiniDefaultScale = mLevel.Mini.scaleX;
			
			mDialogBox = new CurvedBox(new Point(800, 60), Palette.DIALOG_BOX, new BoxLabel("Give a word to the Mini.", 45,
				Palette.DIALOG_CONTENT), 12, Direction.UP_LEFT, Axis.BOTH);
			mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = Math.min(mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2),
				598 - (mDialogBox.height / 2));
			addChild(mDialogBox);
			
			(new Asset.GameHintSound[5]() as Sound).play();
			
			var toolTrayBox:Box = new Box(new Point(1024, 90), Palette.TOOL_BOX);
			toolTrayBox.x = 512;
			toolTrayBox.y = 728;
			addChild(toolTrayBox);
			
			var craftingTrayBox:Box = new Box(new Point(1024, 90), Palette.CRAFTING_BOX);
			craftingTrayBox.x = 512;
			craftingTrayBox.y = 643;
			addChild(craftingTrayBox);
			
			mCraftingTrayField = new CurvedBox(new Point(910, 76), Palette.CRAFTING_FIELD);
			mCraftingTrayField.x = 482;
			mCraftingTrayField.y = 643;
			addChild(mCraftingTrayField);
			
			var craftingIcon:Bitmap = new Asset.IconWriteBitmap();
			craftingIcon.x = 40;
			craftingIcon.y = 643 - (craftingIcon.height / 2);
			addChild(craftingIcon);
			
			mToolTray = new PieceTray(false, mTemplate.WordList);
			mToolTray.x = 90;
			mToolTray.y = 728;
			mToolTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedToolTray);
			addChild(mToolTray);
			
			mCraftingTray = new PieceTray(false);
			mCraftingTray.x = 90;
			mCraftingTray.y = 643;
			mCraftingTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedCraftingTray);
			addChild(mCraftingTray);
			
			mSubmitBtn = new CurvedBox(new Point(64, 64), Palette.GREAT_BTN,
				new BoxIcon(Asset.IconOKBitmap, Palette.BTN_CONTENT), 12);
			mSubmitBtn.x = 982;
			mSubmitBtn.y = 643;
			mSubmitBtn.addEventListener(MouseEvent.CLICK, OnClickSubmitBtn);
			addChild(mSubmitBtn);
			
			mActivityBox = new ActivityBox(mTemplate.ActivityWordList, mTemplate.LineBreakList, mTemplate.RequestVO,
				mTemplate.PhylacteryArrow, true, false, Asset.WordContentSound["_" + mTemplate.Answer.toLowerCase()]);
			mActivityBox.x = 512;
			mActivityBox.y = ((mTemplate.LineBreakList.length + 1) * 40) + 30;
			addChild(mActivityBox);
			
			mLearnedWordList = { };
			
			mResult = Result.WRONG;
			
			mBlocker = new Sprite();
			mBlocker.addEventListener(MouseEvent.CLICK, OnClickBlocker);
			mBlocker.graphics.beginFill(0x000000, 0);
			mBlocker.graphics.drawRect(0, 0, 1024, 768);
			mBlocker.graphics.endFill();
			
			mFloatPieceList = new Vector.<Piece>();
			
			//var areaY:Number = ((mTemplate.LineBreakList.length + 1) * 40) + 180;
			var areaY:Number = ((mTemplate.LineBreakList.length + 1) * 80) + 60 + 40;
			var areaH:Number = (mLevel.Mini.y - (mLevel.Mini.height / 2) - 50) - areaY;
			//mFloatPieceArea = new Rectangle(100, areaY, 824, 400 - areaY);
			mFloatPieceArea = new Rectangle(100, areaY, 824, areaH);
			
			mDragAutostartTimer = new Timer(500, 1);
			mDragAutostartTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnDragAutostartTimerComplete);
			
			UpdateAnswer();
			
			mTutorialTimer = new Timer(3000);
			mTutorialTimer.addEventListener(TimerEvent.TIMER, OnTutorialTimer);
			mTutorialTimer.start();
		}
		
		override public function Dispose():void
		{
			var i:int, endi:int;
			
			mToolTray.removeEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedToolTray);
			mCraftingTray.removeEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedCraftingTray);
			mSubmitBtn.removeEventListener(MouseEvent.CLICK, OnClickSubmitBtn);
			mBlocker.removeEventListener(MouseEvent.CLICK, OnClickBlocker);
			
			mTutorialTimer.reset();
			mTutorialTimer.removeEventListener(TimerEvent.TIMER, OnTutorialTimer);
			
			mToolTray.Dispose();
			mCraftingTray.Dispose();
			
			for (i = 0, endi = mFloatPieceList.length; i < endi; ++i)
			{
				mFloatPieceList[i].removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
				mFloatPieceList[i].removeEventListener(MouseEvent.CLICK, OnClickFloatPiece);
				mFloatPieceList[i].removeEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
				
				mFloatPieceList[i].Dispose();
			}
			mFloatPieceList.splice(0, mFloatPieceList.length);
		}
		
		private function UpdateAnswer():void
		{
			mActivityBox.UpdateCurrentActivityContent(mCraftingTray.AssembleChunkList(), true);
			mSubmitBtn.BoxColor = Palette.GREAT_BTN;
		}
		
		private function StartFloatPieceDrag():void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveDragStage);
			
			mDragAutostartTimer.reset();
			
			mDraggedPiece.Position = MouseUtil.PositionRelativeTo(this);
			
			mDraggedPiece.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
			mDraggedPiece.removeEventListener(MouseEvent.CLICK, OnClickFloatPiece);
			mDraggedPiece.removeEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
			
			mDraggedPiece.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			//if (Asset.LetterSound["_" + mDraggedPiece.Label])
			if (Asset.LetterAudioSound["_" + mDraggedPiece.Label])
			{
				//(new Asset.LetterSound["_" + mDraggedPiece.Label]() as Sound).play();
				(new Asset.LetterAudioSound["_" + mDraggedPiece.Label]() as Sound).play();
			}
			//else if (Asset.ChunkSound["_" + mDraggedPiece.Label])
			//{
				//(new Asset.ChunkSound["_" + mDraggedPiece.Label]() as Sound).play();
			//}
			//else if (Asset.WordSound["_" + mDraggedPiece.Label])
			else if (Asset.WordContentSound["_" + mDraggedPiece.Label])
			{
				//(new Asset.WordSound["_" + mDraggedPiece.Label]() as Sound).play();
				(new Asset.WordContentSound["_" + mDraggedPiece.Label]() as Sound).play();
			}
			
			mFloatPieceList.splice(mFloatPieceList.indexOf(mDraggedPiece), 1);
		}
		
		private function ChunkIsRequired(aChunk:String):Boolean
		{
			return (mTemplate.Answer.indexOf(aChunk) > -1);
		}
		
		private function ShowSuccessFeedback():void
		{
			mSuccessFeedback = new Sprite();
			mSuccessFeedback.addEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			mSuccessFeedback.graphics.beginFill(0x000000, 0);
			mSuccessFeedback.graphics.drawRect(0, 0, 1024, 768);
			mSuccessFeedback.graphics.endFill();
			mSuccessFeedback.alpha = 0;
			addChild(mSuccessFeedback);
			
			addChild(mBlocker);
			
			mSubmitBtn.BoxColor = mResult.Color;
			
			var successLabel:TextField = new TextField();
			successLabel.autoSize = TextFieldAutoSize.CENTER;
			successLabel.selectable = false;
			successLabel.filters = [new DropShadowFilter(1.5, 45, 0x000000, 1, 2, 2, 3, BitmapFilterQuality.HIGH)];
			
			switch (mResult)
			{
				case Result.GREAT:
					successLabel.text = "Click to continue.";
					(new Asset.CrescendoSound() as Sound).play();
					break;
				case Result.VALID:
					successLabel.text = "Great word!\nClick to try again.";
					(new Asset.ValidationSound() as Sound).play();
					break;
				case Result.WRONG:
					successLabel.text = "Click to try again.";
					(new Asset.ErrorSound() as Sound).play();
					break;
				default:
					throw new Error(mResult ? "Result " + mResult.Description + " is not handled" : "No result to handle.");
					return;
			}
			
			successLabel.embedFonts = true;
			successLabel.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 72, mResult.Color,
				null, null, null, null, null, TextFormatAlign.CENTER));
			successLabel.x = 512 - (successLabel.width / 2);
			successLabel.y = 384 - (successLabel.height / 2);
			var successBox:CurvedBox = new CurvedBox(new Point(successLabel.width + 24, successLabel.height), Palette.DIALOG_BOX);
			successBox.alpha = 0.7;
			successBox.x = 512;
			successBox.y = 384;
			mSuccessFeedback.addChild(successBox);
			mSuccessFeedback.addChild(successLabel);
			
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, onComplete:OnTweenShowSuccessFeedback, alpha:1 });
			if (mResult == Result.GREAT)
			{
				if (mSubmitedWord)
				{
					TweenLite.to(mSubmitedWord, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideSubmitedWord, alpha:0 });
				}
				mActivityBox.ProgressCurrentActivity();
			}
			if (mSubmissionHighlight)
			{
				TweenLite.to(mSubmissionHighlight, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideSubmissionHighlight, alpha:0 });
			}
		}
		
		private function OnTutorialTimer(aEvent:TimerEvent):void
		{
			switch (mTutorialStep)
			{
				case 0:
					var selection:Vector.<String> = new Vector.<String>();
					for (var i:int = 0, endi:int = mTemplate.WordList.length; i < endi; ++i)
					{
						if (mTemplate.WordList[i].indexOf(mTemplate.Answer.charAt()) > -1)
						{
							selection.push(mTemplate.WordList[i]);
						}
					}
					mToolTray.CallAttention(selection.join("~"));
					break;
				case 1:
					mTutorialTimer.reset();
					break;
				case 2:
					var pieceSelection:Vector.<Piece> = new Vector.<Piece>();
					for (i = 0, endi = mFloatPieceList.length; i < endi; ++i)
					{
						if (ChunkIsRequired(mFloatPieceList[i].Label))
						{
							pieceSelection.push(mFloatPieceList[i]);
						}
					}
					if (pieceSelection.length)
					{
						var piece:Piece = Random.FromList(pieceSelection) as Piece;
						piece.CallAttention(true);
						addChild(piece);
					}
					break;
				default:
					//mTutorialTimer.reset();
					break;
			}
		}
		
		private function OnPieceFreedToolTray(aEvent:PieceTrayEvent):void
		{
			mTutorialStep = Math.max(mTutorialStep, 1);
			if (mTutorialStep >= 1)
			{
				mLevel.Mini.removeChildAt(0);
				var miniBitmap:Bitmap = new Asset.MiniOpenBitmap();
				miniBitmap.smoothing = true;
				miniBitmap.x = -miniBitmap.width / 2;
				miniBitmap.y = -miniBitmap.height / 2;
				mLevel.Mini.addChild(miniBitmap);
				TweenLite.to(mLevel.Mini, 0.5, { ease:Strong.easeOut,
					y:(mMiniDefaultPosition.y - (mLevel.Mini.height / (8 * mLevel.Mini.scaleY))),
					scaleX:(mMiniDefaultScale * 0.9), scaleY:(mMiniDefaultScale * 1.2) });
				
				if (mTutorialStep >= 3)
				{
					mCraftingTrayField.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
				}
			}
			
			mPreviousPosition = aEvent.EventPiece.NextPiece;
			
			var color:int = (ChunkIsRequired(aEvent.EventPiece.Label) ? ActivityType.WORD_CRAFTING.ColorCode : Palette.DIALOG_BOX);
			mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Label, MouseUtil.PositionRelativeTo(this), color);
			mDraggedPiece.y = mToolTray.y;
			mDraggedPiece.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
			addChild(mDraggedPiece);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			//if (Asset.WordSound["_" + mDraggedPiece.Label])
			if (Asset.WordContentSound["_" + mDraggedPiece.Label])
			{
				//(new Asset.WordSound["_" + mDraggedPiece.Label]() as Sound).play();
				(new Asset.WordContentSound["_" + mDraggedPiece.Label]() as Sound).play();
			}
			
			//mToolTray.InsertLast(aEvent.EventPiece.Label, new Point(mToolTray.width + (aEvent.EventPiece.width / 2)));
			mToolTray.Remove(aEvent.EventPiece);
		}
		
		private function OnTweenSendFedWord(aPiece:Piece):void
		{
			var pieceLabelList:Vector.<String>;
			switch (aPiece.Label)
			{
				case "hill":
					switch (Random.RangeInt(0, 2))
					{
						case 0:
							pieceLabelList = new <String>["h", "i", "l", "l"];
							break;
						case 1:
							pieceLabelList = new <String>["h", "i", "ll"];
							break;
						case 2:
							pieceLabelList = new <String>["h", "ill"];
							break;
						default:
							break;
					}
					break;
				case "felt":
					switch (Random.RangeInt(0, 2))
					{
						case 0:
							pieceLabelList = new <String>["f", "e", "l", "t"];
							break;
						case 1:
							pieceLabelList = new <String>["f", "e", "lt"];
							break;
						case 2:
							pieceLabelList = new <String>["f", "elt"];
							break;
						default:
							break;
					}
					break;
				case "hall":
					switch (Random.RangeInt(0, 2))
					{
						case 0:
							pieceLabelList = new <String>["h", "a", "l", "l"];
							break;
						case 1:
							pieceLabelList = new <String>["h", "a", "ll"];
							break;
						case 2:
							pieceLabelList = new <String>["h", "all"];
							break;
						default:
							break;
					}
					break;
				case "fair":
					switch (Random.RangeInt(0, 1))
					{
						case 0:
							pieceLabelList = new <String>["f", "a", "i", "r"];
							break;
						case 1:
							pieceLabelList = new <String>["f", "a", "ir"];
							break;
						default:
							break;
					}
					break;
				default:
					if (aPiece.Label.length > 1)
					{
						pieceLabelList = new Vector.<String>();
						for (var i:int = 0, endi:int = aPiece.Label.length; i < endi; ++i)
						{
							pieceLabelList.push(aPiece.Label.charAt(i));
						}
					}
					else
					{
						pieceLabelList = new <String>[aPiece.Label];
					}
					break;
			}
			
			TweenLite.to(aPiece, 0.2, { ease:Elastic.easeOut, onComplete:OnTweenStretchFedWord,
				onCompleteParams:[aPiece, pieceLabelList], scaleX:0.5, scaleY:0.01 });
		}
		
		private function OnTweenStretchFedWord(aPiece:Piece, aPieceLabelList:Vector.<String>):void
		{
			mTutorialStep = Math.max(mTutorialStep, 2);
			if (mTutorialStep == 2)
			{
				mTutorialTimer.reset();
				mTutorialTimer.start();
			}
			
			mDialogBox.Content = new BoxLabel("Click the letters and word parts.", 45, Palette.DIALOG_CONTENT);
			mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = Math.min(mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2),
				598 - (mDialogBox.height / 2));
			
			(new Asset.GameHintSound[4]() as Sound).play();
			
			var color:int;
			var piece:Piece;
			var bubble:Bitmap;
			var target:Point;
			for (var i:int = 0, endi:int = aPieceLabelList.length; i < endi; ++i)
			{
				color = (ChunkIsRequired(aPieceLabelList[i]) ? ActivityType.WORD_CRAFTING.ColorCode : Palette.DIALOG_BOX);
				piece = new Piece(null, null, aPieceLabelList[i], DisplayObjectUtil.GetPosition(aPiece), color);
				piece.scaleX = 0.1;
				piece.scaleY = 0.1;
				piece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
				piece.addEventListener(MouseEvent.CLICK, OnClickFloatPiece);
				piece.addEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
				//piece.StartDecay();
				bubble = new Asset.BubbleBitmap();
				bubble.smoothing = true;
				bubble.width = Math.max(bubble.width, piece.width + 30);
				bubble.scaleY = bubble.scaleX;
				bubble.x = -bubble.width / 2;
				bubble.y = -bubble.height / 2;
				piece.addChild(bubble);
				addChild(piece);
				mFloatPieceList.push(piece);
				target = Random.Position2D(mFloatPieceArea);
				TweenLite.to(piece, 2, { ease:Quad.easeOut, delay:(i * 0.1), x:target.x, y:target.y });
				TweenLite.to(piece, 1, { ease:Elastic.easeOut, delay:(i * 0.1), scaleX:1, scaleY:1 });
			}
			
			var sound:Sound = new Asset.BurpSound() as Sound;
			sound.play();
			var burpTimer:Timer = new Timer(sound.length, 1);
			burpTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnBurpTimerComplete);
			burpTimer.start();
			TweenLite.to(mLevel.Mini, 0.5, { ease:Elastic.easeOut, delay:(sound.length / 850), y:mMiniDefaultPosition.y,
				scaleX:mMiniDefaultScale, scaleY:mMiniDefaultScale });
			
			mFloatPieceList.splice(mFloatPieceList.indexOf(aPiece), 1);
			aPiece.Dispose();
			removeChild(aPiece);
		}
		
		private function OnBurpTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnBurpTimerComplete);
			
			mLevel.Mini.removeChildAt(0);
			var miniBitmap:Bitmap = new Asset.MiniBitmap();
			miniBitmap.smoothing = true;
			miniBitmap.x = -miniBitmap.width / 2;
			miniBitmap.y = -miniBitmap.height / 2;
			mLevel.Mini.addChild(miniBitmap);
		}
		
		private function OnPieceFreedCraftingTray(aEvent:PieceTrayEvent):void
		{
			if (mTutorialStep >= 1)
			{
				mLevel.Mini.removeChildAt(0);
				var miniBitmap:Bitmap = new Asset.MiniOpenBitmap();
				miniBitmap.smoothing = true;
				miniBitmap.x = -miniBitmap.width / 2;
				miniBitmap.y = -miniBitmap.height / 2;
				mLevel.Mini.addChild(miniBitmap);
				TweenLite.to(mLevel.Mini, 0.5, { ease:Strong.easeOut,
					y:(mMiniDefaultPosition.y - (mLevel.Mini.height / (8 * mLevel.Mini.scaleY))),
					scaleX:(mMiniDefaultScale * 0.9), scaleY:(mMiniDefaultScale * 1.2) });
				
				if (mTutorialStep >= 3)
				{
					mCraftingTrayField.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
				}
			}
			
			mPreviousPosition = aEvent.EventPiece.NextPiece;
			
			var color:int = (ChunkIsRequired(aEvent.EventPiece.Label) ? ActivityType.WORD_CRAFTING.ColorCode : Palette.DIALOG_BOX);
			mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Label, MouseUtil.PositionRelativeTo(this), color);
			mDraggedPiece.y = mCraftingTray.y;
			mDraggedPiece.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
			addChild(mDraggedPiece);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			mCraftingTray.Remove(aEvent.EventPiece);
			
			UpdateAnswer();
		}
		
		private function OnMouseMoveStage(aEvent:MouseEvent):void
		{
			mDraggedPiece.Position = MouseUtil.PositionRelativeTo(this);
			
			if (mDraggedPiece.getBounds(this).intersects(mLevel.Mini.getBounds(this)))
			{
				mCraftingTray.FreePlace();
			}
			else if (mDraggedPiece.getBounds(this).intersects(mCraftingTrayField.getBounds(this)))
			{
				mCraftingTray.MakePlace(mDraggedPiece);
			}
			else
			{
				mCraftingTray.FreePlace();
			}
		}
		
		private function OnMouseUpStage(aEvent:MouseEvent):void
		{
			mCraftingTrayField.filters = [];
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			var miniBitmap:Bitmap;
			var piece:Piece;
			var color:int;
			var bubble:Bitmap;
			var target:Point;
			if (mDraggedPiece.getBounds(this).intersects(mLevel.Mini.getBounds(this)))
			{
				color = (ChunkIsRequired(mDraggedPiece.Label) ? ActivityType.WORD_CRAFTING.ColorCode : Palette.DIALOG_BOX);
				piece = new Piece(null, null, mDraggedPiece.Label, MouseUtil.PositionRelativeTo(this), color);
				addChild(piece);
				
				mFloatPieceList.push(piece);
				
				TweenLite.to(piece, 0.1, { ease:Strong.easeOut, onComplete:OnTweenSendFedWord,
					onCompleteParams:[piece], x:mMiniDefaultPosition.x, y:mMiniDefaultPosition.y });
				
				mDraggedPiece.Dispose();
				removeChild(mDraggedPiece);
				mDraggedPiece = null;
			}
			else if (mDraggedPiece.getBounds(this).intersects(mCraftingTrayField.getBounds(this)))
			{
				mLevel.Mini.removeChildAt(0);
				miniBitmap = new Asset.MiniBitmap();
				miniBitmap.smoothing = true;
				miniBitmap.x = -miniBitmap.width / 2;
				miniBitmap.y = -miniBitmap.height / 2;
				mLevel.Mini.addChild(miniBitmap);
				TweenLite.to(mLevel.Mini, 0.5, { ease:Elastic.easeOut, y:mMiniDefaultPosition.y,
					scaleX:mMiniDefaultScale, scaleY:mMiniDefaultScale });
				
				mCraftingTray.addEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedCraftingTray);
				mCraftingTray.Insert(mDraggedPiece, mPreviousPosition);
				
				UpdateAnswer();
				
				if (!mFloatPieceList.length)
				{
					if (mToolTray.Empty)
					{
						removeChild(mDialogBox);
					}
					else
					{
						mDialogBox.Content = new BoxLabel("Give a word to the Mini.", 45, Palette.DIALOG_CONTENT);
						mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
						mDialogBox.y = Math.min(mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2),
							598 - (mDialogBox.height / 2));
						
						(new Asset.GameHintSound[5]() as Sound).play();
					}
				}
			}
			else
			{
				mLevel.Mini.removeChildAt(0);
				miniBitmap = new Asset.MiniBitmap();
				miniBitmap.smoothing = true;
				miniBitmap.x = -miniBitmap.width / 2;
				miniBitmap.y = -miniBitmap.height / 2;
				mLevel.Mini.addChild(miniBitmap);
				TweenLite.to(mLevel.Mini, 0.5, { ease:Elastic.easeOut, y:mMiniDefaultPosition.y,
					scaleX:mMiniDefaultScale, scaleY:mMiniDefaultScale });
				
				color = (ChunkIsRequired(mDraggedPiece.Label) ? ActivityType.WORD_CRAFTING.ColorCode : Palette.DIALOG_BOX);
				piece = new Piece(null, null, mDraggedPiece.Label, MouseUtil.PositionRelativeTo(this), color);
				piece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
				piece.addEventListener(MouseEvent.CLICK, OnClickFloatPiece);
				piece.addEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
				//piece.StartDecay();
				bubble = new Asset.BubbleBitmap();
				bubble.smoothing = true;
				bubble.width = Math.max(bubble.width, piece.width + 30);
				bubble.scaleY = bubble.scaleX;
				bubble.x = -bubble.width / 2;
				bubble.y = -bubble.height / 2;
				piece.addChild(bubble);
				addChild(piece);
				mFloatPieceList.push(piece);
				//target = Random.Position2D(mFloatPieceArea);
				//TweenLite.to(piece, 2, { ease:Quad.easeOut, x:target.x, y:target.y });
				target = DisplayObjectUtil.GetPosition(piece);
				if (!mFloatPieceArea.containsPoint(target))
				{
					target.x = MathUtil.MinMax(target.x, mFloatPieceArea.left, mFloatPieceArea.right);
					target.y = MathUtil.MinMax(target.y, mFloatPieceArea.top, mFloatPieceArea.bottom);
					TweenLite.to(piece, 2, { ease:Quad.easeOut, x:target.x, y:target.y });
				}
				
				mDraggedPiece.Dispose();
				removeChild(mDraggedPiece);
				mDraggedPiece = null;
			}
		}
		
		private function OnMouseDownFloatPiece(aEvent:MouseEvent):void
		{
			mTutorialStep = Math.max(mTutorialStep, 3);
			if (mTutorialStep >= 1)
			{
				mLevel.Mini.removeChildAt(0);
				var miniBitmap:Bitmap = new Asset.MiniOpenBitmap();
				miniBitmap.smoothing = true;
				miniBitmap.x = -miniBitmap.width / 2;
				miniBitmap.y = -miniBitmap.height / 2;
				mLevel.Mini.addChild(miniBitmap);
				TweenLite.to(mLevel.Mini, 0.5, { ease:Strong.easeOut,
					y:(mMiniDefaultPosition.y - (mLevel.Mini.height / (8 * mLevel.Mini.scaleY))),
					scaleX:(mMiniDefaultScale * 0.9), scaleY:(mMiniDefaultScale * 1.2) });
				
				if (mTutorialStep >= 3)
				{
					mCraftingTrayField.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
				}
			}
			
			mPreviousPosition = null;
			
			mDraggedPiece = aEvent.currentTarget as Piece;
			mDraggedPiece.removeChildAt(mDraggedPiece.numChildren - 1);
			addChild(mDraggedPiece);
			TweenLite.to(mDraggedPiece, 0.1, { ease:Elastic.easeOut, onComplete:OnTweenSquash, scaleX:1.2, scaleY:0.7 });
			
			var bubbleSplash:Bitmap = new Asset.BubbleSplashBitmap();
			bubbleSplash.x = mDraggedPiece.x - (bubbleSplash.width / 2);
			bubbleSplash.y = mDraggedPiece.y - (bubbleSplash.height / 2);
			addChild(bubbleSplash);
			TweenLite.to(bubbleSplash, 1, { ease:Strong.easeOut, onComplete:OnTweenHideBubbleSplash,
				onCompleteParams:[bubbleSplash], alpha:0 });
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveDragStage);
			
			mMouseDownOrigin = MouseUtil.PositionRelativeTo(mDraggedPiece);
			
			mDragAutostartTimer.reset();
			mDragAutostartTimer.start();
		}
		
		private function OnTweenSquash():void
		{
			TweenLite.to(mDraggedPiece, 0.3, { ease:Elastic.easeOut, scaleX:1, scaleY:1 });
		}
		
		private function OnMouseMoveDragStage(aEvent:MouseEvent):void
		{
			if (mMouseDownOrigin.subtract(MouseUtil.PositionRelativeTo(mDraggedPiece)).length >= 15)
			{
				StartFloatPieceDrag();
			}
		}
		
		private function OnDragAutostartTimerComplete(aEvent:TimerEvent):void
		{
			StartFloatPieceDrag();
		}
		
		private function OnClickFloatPiece(aEvent:MouseEvent):void
		{
			StartFloatPieceDrag();
		}
		
		private function OnTweenHideBubbleSplash(aBubbleSplash:Bitmap):void
		{
			removeChild(aBubbleSplash);
		}
		
		private function OnRemoveFloatPiece(aEvent:PieceEvent):void
		{
			var piece:Piece = aEvent.currentTarget as Piece;
			piece.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
			piece.removeEventListener(MouseEvent.CLICK, OnClickFloatPiece);
			piece.removeEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
			
			mFloatPieceList.splice(mFloatPieceList.indexOf(piece), 1);
			piece.Dispose();
			
			TweenLite.to(piece, 1, { ease:Strong.easeOut, onComplete:OnTweenHideFloatPiece, onCompleteParams:[piece], alpha:0 });
		}
		
		private function OnTweenHideFloatPiece(aPiece:Piece):void
		{
			removeChild(aPiece);
		}
		
		private function OnPieceCapturedCraftingTray(aEvent:PieceTrayEvent):void
		{
			mTutorialStep = Math.max(mTutorialStep, 3);
			
			mCraftingTray.removeEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedCraftingTray);
			
			aEvent.EventPiece.Dispose();
			removeChild(aEvent.EventPiece);
			if (aEvent.EventPiece == mDraggedPiece)
			{
				mDraggedPiece = null;
			}
			
			UpdateAnswer();
		}
		
		private function OnClickSubmitBtn(aEvent:MouseEvent):void
		{
			mStoredCraftingTrayChunkList = mCraftingTray.AssembleChunkList();
			
			var answer:String = mCraftingTray.AssembleWord();
			if (answer.length)
			{
				mAnswer = answer;
				if (mAnswer == mTemplate.Answer)
				{
					mResult = Result.GREAT;
					mLearnedWordList[mAnswer] = mAnswer;
				}
				else if (WordDictionary.Validate(mAnswer, 1))
				{
					mResult = Result.VALID;
					mLearnedWordList[mAnswer] = mAnswer;
				}
				else
				{
					mResult = Result.WRONG;
				}
				
				addChild(mBlocker);
				
				mCraftingTray.Color = (mResult == Result.GREAT ? ActivityType.WORD_CRAFTING.ColorCode : mResult.Color);
				
				if (mResult == Result.WRONG)
				{
					var explodeDuration:Number = mCraftingTray.FizzleAndExplode();
					var explodeWordTimer:Timer = new Timer(explodeDuration * 1000, 1);
					explodeWordTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnExplodeWordTimerComplete);
					explodeWordTimer.start();
				}
				else
				{
					if (mResult == Result.GREAT)
					{
						(new Asset.WordContentSound["_" + mTemplate.Answer.toLowerCase()]() as Sound).play();
					}
					
					var bounceDuration:Number = mCraftingTray.BounceInSequence();
					var submitWordTimer:Timer = new Timer(bounceDuration * 1000, 1);
					submitWordTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnSumbitWordTimerComplete);
					submitWordTimer.start();
				}
				
				(new Asset.SnappingSound() as Sound).play();
			}
			else
			{
				mResult = Result.WRONG;
				mSubmitBtn.BoxColor = mResult.Color;
			}
		}
		
		private function OnClickBlocker(aEvent:MouseEvent):void
		{
		}
		
		private function OnExplodeWordTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnExplodeWordTimerComplete);
			
			mCraftingTray.visible = false;
			
			ShowSuccessFeedback();
		}
		
		private function OnSumbitWordTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnSumbitWordTimerComplete);
			
			var target:Point = mActivityBox.CurrentActivityCenter;
			var scale:Number = 1;
			
			var color:int = (mResult == Result.GREAT ? ActivityType.WORD_CRAFTING.ColorCode : mResult.Color);
			//mSubmitedWord = new UIButton(mAnswer, color);
			mSubmitedWord = new Sprite();
			var chunkLabelList:Vector.<String> = mCraftingTray.AssembleChunkList();
			var chunkList:Vector.<CurvedBox> = new Vector.<CurvedBox>();
			var chunk:CurvedBox;
			var chunkOffset:Number = 0;
			var i:int, endi:int;
			for (i = 0, endi = chunkLabelList.length; i < endi; ++i)
			{
				chunk = new CurvedBox(new Point(60, 60), color, new BoxLabel(chunkLabelList[i], 45, Palette.DIALOG_CONTENT),
					12, null, Axis.HORIZONTAL);
				chunkOffset += chunk.width / 2;
				chunk.x = chunkOffset;
				mSubmitedWord.addChild(chunk);
				chunkList.push(chunk);
				chunkOffset += (chunk.width) / 2;
			}
			var wordOffset:Number = -mSubmitedWord.width / 2;
			for (i = 0, endi = chunkList.length; i < endi; ++i)
			{
				chunkList[i].x += wordOffset;
			}
			mSubmitedWord.x = mCraftingTray.Center;
			mSubmitedWord.y = mCraftingTray.y;
			//mSubmitedWord.width = mCraftingTray.width;
			
			if (mResult == Result.GREAT)
			{
				mSubmissionHighlight = new Sprite();
				mSubmissionHighlight.x = mSubmitedWord.x;
				mSubmissionHighlight.y = mSubmitedWord.y;
				mSubmissionHighlight.addEventListener(Event.ENTER_FRAME, OnEnterFrameSubmissionHighlight);
				var highlightBitmap:Bitmap = new Asset.SubmissionHighlightBitmap() as Bitmap;
				highlightBitmap.smoothing = true;
				highlightBitmap.x = -highlightBitmap.width / 2;
				highlightBitmap.y = -highlightBitmap.height / 2;
				mSubmissionHighlight.addChild(highlightBitmap);
				addChild(mSubmissionHighlight);
				
				TweenLite.to(mSubmissionHighlight, 0.5, { ease:Strong.easeOut, x:target.x, y:target.y, scaleX:1, scaleY:1 } );
				
				//(new Asset.FusionSound() as Sound).play();
				//(new Asset.WordContentSound["_" + mTemplate.Answer.toLowerCase()]() as Sound).play();
			}
			else if (mResult == Result.VALID)
			{
				target = new Point(512, 230);
				scale = 1.5;
			}
			
			addChild(mSubmitedWord);
			
			mCraftingTray.visible = false;
			
			TweenLite.to(mSubmitedWord, 0.5, { ease:Strong.easeOut, onComplete:OnTweenSendSubmitedWord,
				x:target.x, y:target.y, scaleX:scale, scaleY:scale });
		}
		
		private function OnEnterFrameSubmissionHighlight(aEvent:Event):void
		{
			mSubmissionHighlight.rotation += 3;
		}
		
		private function OnTweenSendSubmitedWord():void
		{
			if (mResult == Result.GREAT)
			{
				mActivityBox.UpdateCurrentActivityContent(mCraftingTray.AssembleChunkList());
			}
			
			ShowSuccessFeedback();
		}
		
		private function OnTweenShowSuccessFeedback():void
		{
			removeChild(mBlocker);
		}
		
		private function OnTweenHideSubmitedWord():void
		{
			//mSubmitedWord.Dispose();
			removeChild(mSubmitedWord);
			mSubmitedWord = null;
			
			//if (mResult == Result.GREAT)
			//{
				//(new Asset.SentenceSound["_i_need_to_fill_up_this_cup"]() as Sound).play();
			//}
		}
		
		private function OnTweenHideSubmissionHighlight():void
		{
			removeChild(mSubmissionHighlight);
			mSubmissionHighlight.removeEventListener(Event.ENTER_FRAME, OnEnterFrameSubmissionHighlight);
			mSubmissionHighlight = null;
		}
		
		private function OnClickSuccessFeedback(aEvent:MouseEvent):void
		{
			if (mResult == Result.VALID)
			{
				if (mSubmitedWord)
				{
					TweenLite.to(mSubmitedWord, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideSubmitedWord, alpha:0 });
				}
			}
			
			mSuccessFeedback.removeEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideSuccessFeedback, alpha:0 });
			
			if (mResult != Result.GREAT)
			{
				//mToolTray.Clear(mTemplate.WordList);
				
				mCraftingTray.Clear(mStoredCraftingTrayChunkList);
				mCraftingTray.visible = true;
				
				mStoredCraftingTrayChunkList = null;
				
				//for (var i:int = 0, endi:int = mFloatPieceList.length; i < endi; ++i)
				//{
					//mFloatPieceList[i].removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
					//mFloatPieceList[i].removeEventListener(MouseEvent.CLICK, OnClickFloatPiece);
					//mFloatPieceList[i].removeEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
					//
					//mFloatPieceList[i].Dispose();
					//
					//TweenLite.to(mFloatPieceList[i], 1, { ease:Strong.easeOut, delay:(i * 0.1), onComplete:OnTweenHideFloatPiece,
						//onCompleteParams:[mFloatPieceList[i]], alpha:0 });
				//}
				//mFloatPieceList.splice(0, mFloatPieceList.length);
				
				UpdateAnswer();
			}
		}
		
		private function OnTweenHideSuccessFeedback():void
		{
			removeChild(mSuccessFeedback);
			mSuccessFeedback = null;
			
			if (mResult == Result.GREAT)
			{
				dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
			}
		}
	}
}