package com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.Activity;
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
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTray;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTrayEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.UIButton;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Geometry;
	import com.frimastudio.fj_curriculumassociates_edu.util.MouseUtil;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class WordUnscrambling extends Activity
	{
		private var mTemplate:WordUnscramblingTemplate;
		private var mNPC:Bitmap;
		private var mToolTray:PieceTray;
		private var mCraftingTray:PieceTray;
		private var mSubmitBtn:CurvedBox;
		private var mDialogBox:Box;
		private var mAnswerField:CurvedBox;
		private var mPreviousPosition:Piece;
		private var mDraggedPiece:Piece;
		private var mLearnedWordList:Object;
		private var mSubmitedWord:UIButton;
		private var mResult:Result;
		private var mBlocker:Sprite;
		private var mSuccessFeedback:Sprite;
		
		public function WordUnscrambling(aTemplate:WordUnscramblingTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			mNPC = new mTemplate.NPCAsset();
			mNPC.x = 30;
			mNPC.y = 40;
			addChild(mNPC);
			
			var toolTrayBox:Box = new Box(new Point(1024, 90), Palette.TOOL_BOX);
			toolTrayBox.x = 512;
			toolTrayBox.y = 723;
			addChild(toolTrayBox);
			
			var craftingTrayBox:Box = new Box(new Point(1024, 90), Palette.CRAFTING_BOX);
			craftingTrayBox.x = 512;
			craftingTrayBox.y = 633;
			addChild(craftingTrayBox);
			
			var craftingTrayField:CurvedBox = new CurvedBox(new Point(910, 76), Palette.CRAFTING_FIELD);
			craftingTrayField.x = 482;
			craftingTrayField.y = 633;
			addChild(craftingTrayField);
			
			var craftingIcon:Bitmap = new Asset.IconWriteBitmap();
			craftingIcon.x = 40;
			craftingIcon.y = 633 - (craftingIcon.height / 2);
			addChild(craftingIcon);
			
			mToolTray = new PieceTray(false, mTemplate.LetterList);
			mToolTray.x = 90;
			mToolTray.y = 723;
			mToolTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedToolTray);
			addChild(mToolTray);
			
			mCraftingTray = new PieceTray(false);
			mCraftingTray.x = 90;
			mCraftingTray.y = 633;
			mCraftingTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedCraftingTray);
			addChild(mCraftingTray);
			
			mSubmitBtn = new CurvedBox(new Point(64, 64), Palette.GREAT_BTN,
				new BoxIcon(Asset.IconOKBitmap, Palette.BTN_CONTENT), 12);
			mSubmitBtn.x = 982;
			mSubmitBtn.y = 633;
			mSubmitBtn.addEventListener(MouseEvent.CLICK, OnClickSubmitBtn);
			addChild(mSubmitBtn);
			
			var answerFieldString:String = "____";
			for (var i:int = 0, endi:int = mTemplate.Answer.length; i < endi; ++i)
			{
				answerFieldString += "_";
			}
			var request:String = mTemplate.Request.split("_").join(answerFieldString);
			
			mDialogBox = new Box(new Point(584, 160), Palette.DIALOG_BOX, new BoxLabel(request, 60,
				Palette.DIALOG_CONTENT), 12, Direction.LEFT, Axis.VERTICAL);
			mDialogBox.HideLabelSubString(answerFieldString);
			mDialogBox.x = 640;
			mDialogBox.y = 50 + (mDialogBox.height / 2);
			addChild(mDialogBox);
			
			var answerFieldBoundary:Rectangle = mDialogBox.BoundaryOfLabelSubString(answerFieldString);
			mAnswerField = new CurvedBox(answerFieldBoundary.size, Palette.ANSWER_FIELD, null, 12);
			DisplayObjectUtil.SetPosition(mAnswerField,
				Geometry.RectangleCenter(answerFieldBoundary).add(DisplayObjectUtil.GetPosition(mDialogBox)));
			addChild(mAnswerField);
			
			mLearnedWordList = { };
			
			mResult = Result.WRONG;
			
			mBlocker = new Sprite();
			mBlocker.addEventListener(MouseEvent.CLICK, OnClickBlocker);
			mBlocker.graphics.beginFill(0x000000, 0);
			mBlocker.graphics.drawRect(0, 0, 1024, 768);
			mBlocker.graphics.endFill();
			
			UpdateAnswer();
		}
		
		private function UpdateAnswer():void
		{
			var answer:String = mCraftingTray.AssembleWord();
			if (answer.length)
			{
				answer = answer.charAt(0).toUpperCase() + answer.substring(1);
				mAnswerField.Content = new BoxLabel(answer, 72, Palette.ANSWER_CONTENT);
			}
			else
			{
				mAnswerField.Content = null;
			}
			
			mSubmitBtn.BoxColor = Palette.GREAT_BTN;
		}
		
		private function OnPieceFreedToolTray(aEvent:PieceTrayEvent):void
		{
			if (aEvent.Dragged)
			{
				mPreviousPosition = aEvent.EventPiece.NextPiece;
				
				mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Label, MouseUtil.PositionRelativeTo(this));
				mDraggedPiece.y = mToolTray.y;
				addChild(mDraggedPiece);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
				stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			}
			else
			{
				mCraftingTray.InsertLast(aEvent.EventPiece.Label, MouseUtil.PositionRelativeTo(mCraftingTray));
				
				UpdateAnswer();
			}
			
			(new Asset.LetterSound["_" + aEvent.EventPiece.Label]() as Sound).play();
			
			mToolTray.Remove(aEvent.EventPiece);
		}
		
		private function OnPieceFreedCraftingTray(aEvent:PieceTrayEvent):void
		{
			if (aEvent.Dragged)
			{
				mPreviousPosition = aEvent.EventPiece.NextPiece;
				
				mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Label, MouseUtil.PositionRelativeTo(this));
				mDraggedPiece.y = mCraftingTray.y;
				addChild(mDraggedPiece);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
				stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			}
			else
			{
				mToolTray.InsertLast(aEvent.EventPiece.Label, MouseUtil.PositionRelativeTo(mToolTray));
			}
			
			(new Asset.LetterSound["_" + aEvent.EventPiece.Label]() as Sound).play();
			
			mCraftingTray.Remove(aEvent.EventPiece);
			
			UpdateAnswer();
		}
		
		private function OnMouseMoveStage(aEvent:MouseEvent):void
		{
			mDraggedPiece.Position = MouseUtil.PositionRelativeTo(this);
			
			if (Math.abs(mDraggedPiece.y - mToolTray.y) <= Math.abs(mDraggedPiece.y - mCraftingTray.y))
			{
				mToolTray.MakePlace(mDraggedPiece);
				mCraftingTray.FreePlace();
			}
			else
			{
				mToolTray.FreePlace();
				mCraftingTray.MakePlace(mDraggedPiece);
			}
		}
		
		private function OnMouseUpStage(aEvent:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			if (Math.abs(mDraggedPiece.y - mToolTray.y) <= Math.abs(mDraggedPiece.y - mCraftingTray.y))
			{
				mToolTray.addEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedToolTray);
				mToolTray.Insert(mDraggedPiece, mPreviousPosition);
			}
			else
			{
				mCraftingTray.addEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedCraftingTray);
				mCraftingTray.Insert(mDraggedPiece, mPreviousPosition);
				
				UpdateAnswer();
			}
		}
		
		private function OnPieceCapturedToolTray(aEvent:PieceTrayEvent):void
		{
			mToolTray.removeEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedToolTray);
			
			removeChild(aEvent.EventPiece);
			if (aEvent.EventPiece == mDraggedPiece)
			{
				mDraggedPiece = null;
			}
		}
		
		private function OnPieceCapturedCraftingTray(aEvent:PieceTrayEvent):void
		{
			mCraftingTray.removeEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedCraftingTray);
			
			removeChild(aEvent.EventPiece);
			if (aEvent.EventPiece == mDraggedPiece)
			{
				mDraggedPiece = null;
			}
			
			UpdateAnswer();
		}
		
		private function OnClickSubmitBtn(aEvent:MouseEvent):void
		{
			var answer:String = mCraftingTray.AssembleWord();
			if (answer.length)
			{
				answer = answer.charAt(0).toUpperCase() + answer.substring(1);
				if (answer == mTemplate.Answer)
				{
					mResult = Result.GREAT;
					mLearnedWordList[answer] = answer;
				}
				else if (WordDictionary.Validate(answer, 1))
				{
					mResult = Result.VALID;
					mLearnedWordList[answer] = answer;
				}
				else if (WordDictionary.Validate(answer.toLowerCase(), 1))
				{
					mResult = Result.VALID;
					mLearnedWordList[answer.toLowerCase()] = answer.toLowerCase();
				}
				else
				{
					mResult = Result.WRONG;
				}
				
				mSubmitedWord = new UIButton(answer, mResult.Color);
				mSubmitedWord.x = mCraftingTray.Center;
				mSubmitedWord.y = mCraftingTray.y;
				mSubmitedWord.width = mCraftingTray.width;
				addChild(mSubmitedWord);
				
				mCraftingTray.visible = false;
				
				addChild(mBlocker);
				
				TweenLite.to(mSubmitedWord, 0.5, { ease:Strong.easeIn, onComplete:OnTweenSquashSubmitedWord, scaleX:1 });
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
		
		private function OnTweenSquashSubmitedWord():void
		{
			(new Asset.SnappingSound() as Sound).play();
			
			TweenLite.to(mSubmitedWord, 1, { ease:Elastic.easeOut, onComplete:OnTweenStretchSubmitedWord, scaleX:1.2, scaleY:1.2 });
		}
		
		private function OnTweenStretchSubmitedWord():void
		{
			TweenLite.to(mSubmitedWord, 0.5, { ease:Strong.easeOut, onComplete:OnTweenSendSubmitedWord,
				x:mAnswerField.x, y:mAnswerField.y, scaleX:1, scaleY:1 });
		}
		
		private function OnTweenSendSubmitedWord():void
		{
			mSuccessFeedback = new Sprite();
			mSuccessFeedback.addEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			mSuccessFeedback.graphics.beginFill(0x000000, 0);
			mSuccessFeedback.graphics.drawRect(0, 0, 1024, 768);
			mSuccessFeedback.graphics.endFill();
			mSuccessFeedback.alpha = 0;
			addChild(mSuccessFeedback);
			
			addChild(mBlocker);
			
			var answer:String = mCraftingTray.AssembleWord();
			answer = answer.charAt(0).toUpperCase() + answer.substring(1);
			mAnswerField.Content = new BoxLabel(answer, 72, mResult.Color, true);
			mSubmitBtn.BoxColor = mSubmitedWord.BoxColor = mResult.Color;
			
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
					successLabel.text = "Great word!\nClick to try again";
					(new Asset.ValidationSound() as Sound).play();
					break;
				case Result.WRONG:
					successLabel.text = "Click to try again";
					(new Asset.ErrorSound() as Sound).play();
					break;
				default:
					throw new Error(mResult ? "Result " + mResult.Description + " is not handled" : "No result to handle.");
					return;
			}
			
			successLabel.embedFonts = true;
			successLabel.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 72, mResult.Color,
				null, null, null, null, null, "center"));
			successLabel.x = 512 - (successLabel.width / 2);
			successLabel.y = 384 - (successLabel.height / 2);
			mSuccessFeedback.addChild(successLabel);
			
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, alpha:1 } );
			TweenLite.to(mSubmitedWord, 0.5, { ease:Strong.easeOut, onComplete:OnTweenDisappearSubmitedWord, alpha:0 });
		}
		
		private function OnTweenDisappearSubmitedWord():void
		{
			mSubmitedWord.Dispose();
			removeChild(mSubmitedWord);
			mSubmitedWord = null;
			
			removeChild(mBlocker);
			
			if (mResult == Result.GREAT)
			{
				(new Asset.SentenceSound["_i_am_sam"]() as Sound).play();
			}
		}
		
		private function OnClickSuccessFeedback(aEvent:MouseEvent):void
		{
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideSuccessFeedback, alpha:0 });
			
			if (mResult != Result.GREAT)
			{
				mCraftingTray.visible = true;
			}
		}
		
		private function OnTweenHideSuccessFeedback():void
		{
			mSuccessFeedback.removeEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			removeChild(mSuccessFeedback);
			mSuccessFeedback = null;
			
			if (mResult == Result.GREAT)
			{
				dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
			}
		}
	}
}