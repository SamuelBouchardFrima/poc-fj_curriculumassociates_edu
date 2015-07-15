package com.frimastudio.fj_curriculumassociates_edu.activity.sentencedecrypting
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.Activity;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityBox;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityBoxEvent;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.activity.Result;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxTiledLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.Piece;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTray;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTrayEvent;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.MathUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.MouseUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	import com.frimastudio.fj_curriculumassociates_edu.util.StringUtil;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	public class SentenceDecrypting extends Activity
	{
		private var mTemplate:SentenceDecryptingTemplate;
		private var mToolTrayField:CurvedBox;
		private var mToolTray:PieceTray;
		private var mPreviousPosition:Piece;
		private var mDraggedPiece:Piece;
		private var mAnswer:String;
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
		private var mCurrentLetterList:String;
		
		public function SentenceDecrypting(aTemplate:SentenceDecryptingTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			mMiniDefaultPosition = DisplayObjectUtil.GetPosition(mLevel.Mini);
			mMiniDefaultScale = mLevel.Mini.scaleX;
			
			mDialogBox = new CurvedBox(new Point(800, 60), Palette.DIALOG_BOX, new BoxLabel("Give a word to the Mini.", 45,
				Palette.DIALOG_CONTENT), 3, Direction.UP_LEFT, Axis.BOTH);
			mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = Math.min(mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2),
				668 - (mDialogBox.height / 2));
			addChild(mDialogBox);
			
			(new Asset.GameHintSound[5]() as Sound).play();
			
			var toolTrayBox:Box = new Box(new Point(1024, 90), Palette.TOOL_BOX);
			toolTrayBox.x = 512;
			toolTrayBox.y = 723;
			addChild(toolTrayBox);
			
			mToolTrayField = new CurvedBox(new Point(910, 76), Palette.TOOL_BOX);
			mToolTrayField.x = 482;
			mToolTrayField.y = 723;
			addChild(mToolTrayField);
			
			//var splitedAnswer:Vector.<String> = Vector.<String>(mTemplate.Answer.split(" "));
			var letterList:String = "";
			var i:int, endi:int;
			var wordTemplate:EncryptedWordTemplate;
			var index:int;
			var char:String;
			for (i = 0, endi = mTemplate.ActivityWordList.length; i < endi; ++i)
			{
				if (mTemplate.ActivityWordList[i].ActivityToLaunch == ActivityType.SENTENCE_DECRYPTING)
				{
					wordTemplate = mTemplate.ActivityWordList[i] as EncryptedWordTemplate;
					index = wordTemplate.ChunkList.join("").indexOf("_");
					while (index != -1)
					{
						char = wordTemplate.Answer.charAt(index);
						if (StringUtil.CharIsAlphabet(char) && letterList.indexOf(char) == -1)
						{
							letterList += char;
						}
						index = wordTemplate.ChunkList.join("").indexOf("_", index + 1);
					}
				}
			}
			//mToolTray = new PieceTray(false, mTemplate.WordList);
			mToolTray = new PieceTray(false, Inventory.RequestWordSelection(letterList));
			mToolTray.x = 90;
			mToolTray.y = 723;
			mToolTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedToolTray);
			addChild(mToolTray);
			
			//mAnswer = mTemplate.Request;
			mAnswer = "";
			for (i = 0, endi = mTemplate.ActivityWordList.length; i < endi; ++i)
			{
				if (i > 0)
				{
					mAnswer += " ";
				}
				mAnswer += mTemplate.ActivityWordList[i].ChunkList.join("");
			}
			
			mActivityBox = new ActivityBox(mTemplate.ActivityWordList, mTemplate.LineBreakList, mTemplate.RequestVO,
				mTemplate.PhylacteryArrow, false, true);
			mActivityBox.StepTemplate = mTemplate;
			mActivityBox.x = 512;
			mActivityBox.y = ((mTemplate.LineBreakList.length + 1) * 40) + 30;
			mActivityBox.addEventListener(ActivityBoxEvent.LAUNCH_ACTIVITY, OnLaunchActivity);
			mActivityBox.addEventListener(ActivityBoxEvent.COMPLETE_ACTIVITY, OnCompleteActivity);
			addChild(mActivityBox);
			
			mBlocker = new Sprite();
			mBlocker.addEventListener(MouseEvent.CLICK, OnClickBlocker);
			mBlocker.graphics.beginFill(0x000000, 0);
			mBlocker.graphics.drawRect(0, 0, 1024, 768);
			mBlocker.graphics.endFill();
			
			mFloatPieceList = new Vector.<Piece>();
			
			var areaY:Number = ((mTemplate.LineBreakList.length + 1) * 80) + 60 + 40;
			var areaH:Number = (mLevel.Mini.y - (mLevel.Mini.height / 2) - 50) - areaY;
			//mFloatPieceArea = new Rectangle(100, areaY, 824, 400 - areaY);
			mFloatPieceArea = new Rectangle(100, areaY, 824, areaH);
			
			mCurrentLetterList = "";
			
			mDragAutostartTimer = new Timer(500, 1);
			mDragAutostartTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnDragAutostartTimerComplete);
			
			mTutorialTimer = new Timer(3000);
			mTutorialTimer.addEventListener(TimerEvent.TIMER, OnTutorialTimer);
			mTutorialTimer.start();
			
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
		}
		
		private function OnEnterFrame(aEvent:Event):void
		{
			var i:int, endi:int, iTarget:Point;
			var j:int, endj:int, jTarget:Point;
			for (i = mFloatPieceList.length - 1, endi = 0; i >= endi; --i)
			{
				if (!ChunkIsRequired(mFloatPieceList[i].Label))
				{
					mFloatPieceList[i].removeEventListener(MouseEvent.CLICK, OnClickFloatPiece);
					mFloatPieceList[i].BoxColor = Palette.DIALOG_BOX;
					mFloatPieceList[i].StartDecay(200);
					mFloatPieceList.splice(i, 1);
				}
			}
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
		
		private function OnLaunchActivity(aEvent:ActivityBoxEvent):void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.LAUNCH_ACTIVITY, aEvent.ActivityToLaunch));
		}
		
		private function OnCompleteActivity(aEvent:ActivityBoxEvent):void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE, null, mActivityBox.WordTemplateList));
		}
		
		override public function Dispose():void
		{
			removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
			
			var i:int, endi:int;
			for (i = 0, endi = mFloatPieceList.length; i < endi; ++i)
			{
				TweenLite.killTweensOf(mFloatPieceList[i]);
				
				mFloatPieceList[i].removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
				mFloatPieceList[i].removeEventListener(MouseEvent.CLICK, OnClickFloatPiece);
				mFloatPieceList[i].removeEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
			}
			
			mBlocker.removeEventListener(MouseEvent.CLICK, OnClickBlocker);
			
			mToolTray.removeEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedToolTray);
			
			mTutorialTimer.reset();
			mTutorialTimer.removeEventListener(TimerEvent.TIMER, OnTutorialTimer);
			
			mToolTray.Dispose();
		}
		
		private function UpdateAnswer(aNewAnswer:String, aAddedCharacter:String):void
		{
			var targetTileList:Vector.<int> = new Vector.<int>();
			var i:int, endi:int;
			var j:int, endj:int;
			for (i = 0, endi = aNewAnswer.length; i < endi; ++i)
			{
				if (aNewAnswer.charAt(i) != mAnswer.charAt(i))
				{
					targetTileList.push(i);
				}
			}
			
			mAnswer = aNewAnswer;
			
			var answerWordList:Vector.<String> = Vector.<String>(mAnswer.split(" "));
			for (i = 0, endi = mTemplate.ActivityWordList.length; i < endi; ++i)
			{
				if (mTemplate.ActivityWordList[i].ActivityToLaunch == ActivityType.SENTENCE_DECRYPTING)
				{
					for (j = 0, endj = mTemplate.ActivityWordList[i].ChunkList.length; j < endj; ++j)
					{
						if (j < answerWordList[i].length)
						{
							mTemplate.ActivityWordList[i].ChunkList[j] = answerWordList[i].charAt(j);
						}
						else
						{
							mTemplate.ActivityWordList[i].ChunkList[j] = " ";
						}
					}
				}
			}
			
			mActivityBox.WordTemplateList = mTemplate.ActivityWordList;
			
			for (i = 0, endi = answerWordList.length; i < endi; ++i)
			{
				if (mTemplate.ActivityWordList[i].ActivityToLaunch != ActivityType.NONE)
				{
					if (answerWordList[i].indexOf("_") == -1)
					{
						mActivityBox.ProgressWord(i);
					}
				}
			}
			mActivityBox.UpdateContent();
			
			if (mAnswer == mTemplate.Answer)
			{
				var whiteBox:CurvedBox;
				for (i = 0, endi = mFloatPieceList.length; i < endi; ++i)
				{
					whiteBox = new CurvedBox(mFloatPieceList[i].Size, 0xFFFFFF);
					whiteBox.x = mFloatPieceList[i].x;
					whiteBox.y = mFloatPieceList[i].y;
					whiteBox.alpha = 0;
					addChild(whiteBox);
					TweenLite.to(whiteBox, 0.1, { ease:Strong.easeOut, delay:(i * 0.07), onComplete:OnTweenWhitenPiece,
						onCompleteParams:[mFloatPieceList[i], whiteBox], alpha:1 });
				}
				mFloatPieceList.splice(0, mFloatPieceList.length);
				
				ShowSuccessFeedback();
			}
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
			
			if (mFloatPieceList.indexOf(mDraggedPiece) > -1)
			{
				mFloatPieceList.splice(mFloatPieceList.indexOf(mDraggedPiece), 1);
				//trace("REMOVED DUE TO DRAG START");
			}
		}
		
		private function ChunkIsRequired(aChunk:String):Boolean
		{
			//if (mCurrentLetterList.split(aChunk).length - 1 >= mTemplate.Answer.split(aChunk).length - 1)
			//{
				//return false;
			//}
			
			//var letterList:String = "";
			var i:int, endi:int;
			var wordTemplate:EncryptedWordTemplate;
			var index:int;
			var char:String;
			for (i = 0, endi = mTemplate.ActivityWordList.length; i < endi; ++i)
			{
				if (mTemplate.ActivityWordList[i].ActivityToLaunch == ActivityType.SENTENCE_DECRYPTING)
				{
					wordTemplate = mTemplate.ActivityWordList[i] as EncryptedWordTemplate;
					index = wordTemplate.ChunkList.join("").indexOf("_");
					while (index != -1)
					{
						char = wordTemplate.Answer.charAt(index).toLowerCase();
						if (char == aChunk && mCurrentLetterList.indexOf(char) == -1)
						{
							return true;
						}
						//if (letterList.indexOf(char) == -1)
						//{
							//letterList += char;
						//}
						index = wordTemplate.ChunkList.join("").indexOf("_", index + 1);
					}
				}
			}
			return false;
			
			//var index:int = mAnswer.indexOf("_");
			//while (index > -1)
			//{
				//if (mTemplate.Answer.substr(index, aChunk.length).toLowerCase() == aChunk.toLowerCase())
				//{
					//return true;
				//}
				//index = mAnswer.indexOf("_", index + 1);
			//}
			//return false;
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
			
			var successLabel:TextField = new TextField();
			successLabel.autoSize = TextFieldAutoSize.CENTER;
			successLabel.selectable = false;
			successLabel.filters = [new DropShadowFilter(1.5, 45, 0x000000, 1, 2, 2, 3, BitmapFilterQuality.HIGH)];
			successLabel.text = "Click to continue.";
			successLabel.embedFonts = true;
			successLabel.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 72, Result.GREAT.Color,
				null, null, null, null, null, TextFormatAlign.CENTER));
			successLabel.x = 512 - (successLabel.width / 2);
			successLabel.y = 384 - (successLabel.height / 2);
			var successBox:CurvedBox = new CurvedBox(new Point(successLabel.width + 24, successLabel.height), Palette.DIALOG_BOX);
			successBox.alpha = 0.7;
			successBox.x = 512;
			successBox.y = 384;
			mSuccessFeedback.addChild(successBox);
			mSuccessFeedback.addChild(successLabel);
			
			(new Asset.CrescendoSound() as Sound).play();
			
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, onComplete:OnTweenShowSuccessFeedback, alpha:1 });
		}
		
		private function OnTutorialTimer(aEvent:TimerEvent):void
		{
			var i:int, endi:int;
			switch (mTutorialStep)
			{
				case 0:
					//var selection:Vector.<String> = new Vector.<String>();
					//for (i = 0, endi = mTemplate.WordList.length; i < endi; ++i)
					//{
						//if (mTemplate.WordList[i].indexOf(mTemplate.Answer.charAt()) > -1)
						//{
							//selection.push(mTemplate.WordList[i]);
						//}
					//}
					//mToolTray.CallAttention(selection.join("~"));
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
					break;
			}
		}
		
		private function OnTweenSendFedWord(aPiece:Piece):void
		{
			TweenLite.to(aPiece, 0.2, { ease:Elastic.easeOut, onComplete:OnTweenStretchFedWord,
				onCompleteParams:[aPiece, Vector.<String>(aPiece.Label.split(""))], scaleX:0.5, scaleY:0.01 });
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
				668 - (mDialogBox.height / 2));
			
			(new Asset.GameHintSound[4]() as Sound).play();
			
			var piece:Piece;
			var bubble:Bitmap;
			var target:Point;
			for (var i:int = 0, endi:int = aPieceLabelList.length; i < endi; ++i)
			{
				if (ChunkIsRequired(aPieceLabelList[i]))
				{
					piece = new Piece(null, null, aPieceLabelList[i], DisplayObjectUtil.GetPosition(aPiece),
						ActivityType.SENTENCE_DECRYPTING.ColorCode);
					//piece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
					piece.addEventListener(MouseEvent.CLICK, OnClickFloatPiece);
				}
				else if (aPieceLabelList[i].length > 1)
				{
					piece = new Piece(null, null, aPieceLabelList[i], DisplayObjectUtil.GetPosition(aPiece), Palette.DIALOG_BOX);
					//piece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
					piece.addEventListener(MouseEvent.CLICK, OnClickFloatPiece);
				}
				else
				{
					piece = new Piece(null, null, aPieceLabelList[i], DisplayObjectUtil.GetPosition(aPiece), Palette.DIALOG_BOX);
					piece.StartDecay(1000);
				}
				piece.addEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
				piece.scaleX = 0.1;
				piece.scaleY = 0.1;
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
			
			if (mFloatPieceList.indexOf(aPiece) > -1)
			{
				mFloatPieceList.splice(mFloatPieceList.indexOf(aPiece), 1);
				//trace("REMOVED DUE TO BEING EATEN");
			}
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
					mActivityBox.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
				}
			}
			
			//mPreviousPosition = aEvent.EventPiece.NextPiece;
			//
			//var color:int = (ChunkIsRequired(aEvent.EventPiece.Label) ? ActivityType.SENTENCE_DECRYPTING.ColorCode : Palette.DIALOG_BOX);
			//mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Label, MouseUtil.PositionRelativeTo(this), color);
			//mDraggedPiece.y = mToolTray.y;
			//mDraggedPiece.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
			//addChild(mDraggedPiece);
			//stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			//stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			//if (Asset.WordSound["_" + mDraggedPiece.Label])
			if (Asset.WordContentSound["_" + aEvent.EventPiece.Label])
			{
				//(new Asset.WordSound["_" + mDraggedPiece.Label]() as Sound).play();
				(new Asset.WordContentSound["_" + aEvent.EventPiece.Label]() as Sound).play();
			}
			
			var color:int = aEvent.EventPiece.BoxColor;
			var sentWord:Piece = new Piece(null, null, aEvent.EventPiece.Label, MouseUtil.PositionRelativeTo(this), color);
			sentWord.y = mToolTray.y;
			addChild(sentWord);
			TweenLite.to(sentWord, 1, { ease:Elastic.easeOut, onComplete:OnTweenSendFedWord,
				onCompleteParams:[sentWord], x:mMiniDefaultPosition.x, y:mMiniDefaultPosition.y });
			
			mToolTray.Remove(aEvent.EventPiece);
		}
		
		private function OnMouseMoveStage(aEvent:MouseEvent):void
		{
			mDraggedPiece.Position = MouseUtil.PositionRelativeTo(this);
		}
		
		private function OnMouseUpStage(aEvent:MouseEvent):void
		{
			mActivityBox.filters = [];
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			var miniBitmap:Bitmap;
			var piece:Piece;
			var bubble:Bitmap;
			var color:int;
			var target:Point;
			if (mDraggedPiece.getBounds(this).intersects(mLevel.Mini.getBounds(this)))
			{
				color = (ChunkIsRequired(mDraggedPiece.Label) ? ActivityType.SENTENCE_DECRYPTING.ColorCode : Palette.DIALOG_BOX);
				piece = new Piece(null, null, mDraggedPiece.Label, MouseUtil.PositionRelativeTo(this), color);
				addChild(piece);
				
				mFloatPieceList.push(piece);
				
				TweenLite.to(piece, 0.1, { ease:Strong.easeOut, onComplete:OnTweenSendFedWord,
					onCompleteParams:[piece], x:mMiniDefaultPosition.x, y:mMiniDefaultPosition.y });
				
				mDraggedPiece.Dispose();
				removeChild(mDraggedPiece);
				mDraggedPiece = null;
			}
			else if (mDraggedPiece.getBounds(this).intersects(mActivityBox.getBounds(this)))
			{
				var index:int = mTemplate.Answer.toLowerCase().indexOf(mDraggedPiece.Label);
				if (index > -1)
				{
					var newAnswer:String = mAnswer;
					do
					{
						if (newAnswer.charAt(index) == "_")
						{
							newAnswer = newAnswer.substring(0, index) + mDraggedPiece.Label +
								newAnswer.substr(index + mDraggedPiece.Label.length);
						}
						index = mTemplate.Answer.toLowerCase().indexOf(mDraggedPiece.Label, index + 1);
					}
					while (index > -1);
					
					if (newAnswer != mAnswer)
					{
						//var whiteBox:CurvedBox = new CurvedBox(mDraggedPiece.Size, Palette.GREAT_BTN);
						//whiteBox.x = mDraggedPiece.x;
						//whiteBox.y = mDraggedPiece.y;
						//whiteBox.alpha = 0;
						//addChild(whiteBox);
						//TweenLite.to(whiteBox, 0.1, { ease:Strong.easeOut, onComplete:OnTweenWhitenPiece,
							//onCompleteParams:[mDraggedPiece, whiteBox], alpha:1 });
						
						TweenLite.to(mDraggedPiece, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideDraggedPiece,
							onCompleteParams:[mDraggedPiece], alpha:0 });
						
						UpdateAnswer(newAnswer.charAt(0).toUpperCase() + newAnswer.substr(1), mDraggedPiece.Label);
						
						//TweenLite.killTweensOf(mDraggedPiece);
						mDraggedPiece = null;
						
						mLevel.Mini.removeChildAt(0);
						miniBitmap = new Asset.MiniBitmap();
						miniBitmap.smoothing = true;
						miniBitmap.x = -miniBitmap.width / 2;
						miniBitmap.y = -miniBitmap.height / 2;
						mLevel.Mini.addChild(miniBitmap);
						TweenLite.to(mLevel.Mini, 0.5, { ease:Elastic.easeOut, y:mMiniDefaultPosition.y,
							scaleX:mMiniDefaultScale, scaleY:mMiniDefaultScale });
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
						
						if (ChunkIsRequired(mDraggedPiece.Label))
						{
							piece = new Piece(null, null, mDraggedPiece.Label, MouseUtil.PositionRelativeTo(this),
								ActivityType.SENTENCE_DECRYPTING.ColorCode);
							//piece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
							piece.addEventListener(MouseEvent.CLICK, OnClickFloatPiece);
						}
						else if (mDraggedPiece.Label.length > 1)
						{
							piece = new Piece(null, null, mDraggedPiece.Label, MouseUtil.PositionRelativeTo(this),
								Palette.DIALOG_BOX);
							//piece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
							piece.addEventListener(MouseEvent.CLICK, OnClickFloatPiece);
						}
						else
						{
							piece = new Piece(null, null, mDraggedPiece.Label, MouseUtil.PositionRelativeTo(this),
								Palette.DIALOG_BOX);
							piece.StartDecay(300);
						}
						piece.addEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
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
					
					if (ChunkIsRequired(mDraggedPiece.Label))
					{
						piece = new Piece(null, null, mDraggedPiece.Label, MouseUtil.PositionRelativeTo(this),
							ActivityType.SENTENCE_DECRYPTING.ColorCode);
						//piece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
						piece.addEventListener(MouseEvent.CLICK, OnClickFloatPiece);
					}
					else if (mDraggedPiece.Label.length > 1)
					{
						piece = new Piece(null, null, mDraggedPiece.Label, MouseUtil.PositionRelativeTo(this), Palette.DIALOG_BOX);
						//piece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
						piece.addEventListener(MouseEvent.CLICK, OnClickFloatPiece);
					}
					else
					{
						piece = new Piece(null, null, mDraggedPiece.Label, MouseUtil.PositionRelativeTo(this), Palette.DIALOG_BOX);
						piece.StartDecay(300);
					}
					piece.addEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
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
							668 - (mDialogBox.height / 2));
						
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
				
				if (ChunkIsRequired(mDraggedPiece.Label))
				{
					piece = new Piece(null, null, mDraggedPiece.Label, MouseUtil.PositionRelativeTo(this),
						ActivityType.SENTENCE_DECRYPTING.ColorCode);
					//piece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
					piece.addEventListener(MouseEvent.CLICK, OnClickFloatPiece);
				}
				else if (mDraggedPiece.Label.length > 1)
				{
					piece = new Piece(null, null, mDraggedPiece.Label, MouseUtil.PositionRelativeTo(this), Palette.DIALOG_BOX);
					//piece.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFloatPiece);
					piece.addEventListener(MouseEvent.CLICK, OnClickFloatPiece);
				}
				else
				{
					piece = new Piece(null, null, mDraggedPiece.Label, MouseUtil.PositionRelativeTo(this), Palette.DIALOG_BOX);
					piece.StartDecay(300);
				}
				piece.addEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
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
		
		private function OnTweenHideDraggedPiece(aPiece:Piece):void
		{
			TweenLite.killTweensOf(aPiece);
			aPiece.Dispose();
			removeChild(aPiece);
		}
		
		private function OnTweenWhitenPiece(aPiece:Piece, aWhiteBox:CurvedBox):void
		{
			TweenLite.to(aWhiteBox, 0.15, { ease:Strong.easeIn, onComplete:OnTweenExplodePiece,
				onCompleteParams:[aWhiteBox], scaleX:1.2, scaleY:1.2 } );
			
			if (mFloatPieceList.indexOf(aPiece) > -1)
			{
				var bubbleSplash:Bitmap = new Asset.BubbleSplashBitmap();
				bubbleSplash.x = aPiece.x - (bubbleSplash.width / 2);
				bubbleSplash.y = aPiece.y - (bubbleSplash.height / 2);
				addChild(bubbleSplash);
				TweenLite.to(bubbleSplash, 1, { ease:Strong.easeOut, onComplete:OnTweenHideBubbleSplash,
					onCompleteParams:[bubbleSplash], alpha:0 });
			}
			
			aPiece.Dispose();
			removeChild(aPiece);
		}
		
		private function OnTweenExplodePiece(aWhiteBox:CurvedBox):void
		{
			var explosion:MovieClip = new Asset.PieceExplosionClip() as MovieClip;
			explosion.x = aWhiteBox.x;
			explosion.y = aWhiteBox.y;
			//var colorTransform:ColorTransform = new ColorTransform();
			//colorTransform.color = Palette.GREAT_BTN;
			//explosion.transform.colorTransform = colorTransform;
			addChild(explosion);
			
			TweenLite.to(aWhiteBox, 0.3, { ease:Strong.easeOut, delay:0.2, onComplete:OnTweenHideExplosion,
				onCompleteParams:[aWhiteBox, explosion], scaleX:2, scaleY:2, alpha:0 });
			
			(new Asset.PieceExplosionSound() as Sound).play();
		}
		
		private function OnTweenHideExplosion(aWhiteBox:CurvedBox, aExplosion:MovieClip):void
		{
			removeChild(aWhiteBox);
			removeChild(aExplosion);
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
					mActivityBox.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
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
			//StartFloatPieceDrag();
			
			var piece:Piece = aEvent.currentTarget as Piece;
			var letter:String = piece.Label;
			
			var newPiece:Piece;
			//var target:Point;
			var slotList:Vector.<Point> = mActivityBox.SlotListForLetter(letter);
			for (var i:int = 0, endi:int = slotList.length; i < endi; ++i)
			{
				newPiece = new Piece(null, null, letter, DisplayObjectUtil.GetPosition(piece),
					ActivityType.SENTENCE_DECRYPTING.ColorCode);
				//target = new Point();	// TODO:	find the position of the next slot for letter
				TweenLite.to(newPiece, 1, { ease:Elastic.easeOut, onComplete:OnTweenSendPieceToActivitySlot,
					onCompleteParams:[newPiece], x:slotList[i].x, y:slotList[i].y } );
				addChild(newPiece);
			}
			
			TweenLite.to(this, 1, { onComplete:OnTweenSendPieceListToCorrespondingSlot, onCompleteParams:[letter] });
			
			//piece.removeChildAt(piece.numChildren - 1);
			//addChild(piece);
			removeChild(piece);
			if (mFloatPieceList.indexOf(piece) > -1)
			{
				mFloatPieceList.splice(mFloatPieceList.indexOf(piece), 1);
				//trace("REMOVED DUE TO BEING SELECTED");
			}
			
			mCurrentLetterList += letter;
			
			var bubbleSplash:Bitmap = new Asset.BubbleSplashBitmap();
			bubbleSplash.x = piece.x - (bubbleSplash.width / 2);
			bubbleSplash.y = piece.y - (bubbleSplash.height / 2);
			addChild(bubbleSplash);
			TweenLite.to(bubbleSplash, 1, { ease:Strong.easeOut, onComplete:OnTweenHideBubbleSplash,
				onCompleteParams:[bubbleSplash], alpha:0 });
			
			//var target:Point = mActivityBox.CurrentActivityEmptySlot;
			//var target:Point = mActivityBox.SentenceCenter;
			//TweenLite.to(piece, 1, { ease:Elastic.easeOut, onComplete:OnTweenSendPieceToActivitySlot,
				//onCompleteParams:[piece], x:target.x, y:target.y });
		}
		
		private function OnTweenSendPieceToActivitySlot(aPiece:Piece):void
		{
			removeChild(aPiece);
		}
		
		//private function OnTweenSendPieceToActivitySlot(aPiece:Piece, aSlot:int):void
		private function OnTweenSendPieceListToCorrespondingSlot(aLetter:String):void
		{
			var effective:Boolean = mActivityBox.DecryptSentence(aLetter);
			//var effective:Boolean = mActivityBox.DecryptCharacter(aPiece.Label, aSlot);
			if (effective)
			{
				//removeChild(aPiece);
				
				if (mActivityBox.SentenceDecryptionFinished)
				{
					dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE, null, mActivityBox.WordTemplateList));
				}
			}
			//else
			//{
				// TODO:	return piece to float area
			//}
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
			
			if (mFloatPieceList.indexOf(piece) > -1)
			{
				mFloatPieceList.splice(mFloatPieceList.indexOf(piece), 1);
				//trace("REMOVED AS REQUESTED BY THE PIECE ITSELF");
			}
			piece.Dispose();
			
			if (!mFloatPieceList.length && !mToolTray.Empty)
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
						668 - (mDialogBox.height / 2));
					
					(new Asset.GameHintSound[5]() as Sound).play();
				}
			}
			
			TweenLite.to(piece, 1, { ease:Strong.easeOut, onComplete:OnTweenHideFloatPiece, onCompleteParams:[piece], alpha:0 } );
		}
		
		private function OnTweenHideFloatPiece(aPiece:Piece):void
		{
			if (contains(aPiece))
			{
				removeChild(aPiece);
			}
		}
		
		private function OnClickBlocker(aEvent:MouseEvent):void
		{
		}
		
		private function OnTweenShowSuccessFeedback():void
		{
			removeChild(mBlocker);
			
			if (mAnswer.indexOf("_") == -1)
			{
				(new mTemplate.RequestVO() as Sound).play();
			}
		}
		
		private function OnClickSuccessFeedback(aEvent:MouseEvent):void
		{
			mSuccessFeedback.removeEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideSuccessFeedback, alpha:0 });
		}
		
		private function OnTweenHideSuccessFeedback():void
		{
			removeChild(mSuccessFeedback);
			mSuccessFeedback = null;
			
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}