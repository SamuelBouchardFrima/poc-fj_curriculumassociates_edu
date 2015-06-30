package com.frimastudio.fj_curriculumassociates_edu.activity.familysort
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.Activity;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.Result;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.MouseUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	public class FamilySort extends Activity
	{
		private static const FAMILY_COLOR:Vector.<int> = new <int>[0xFF9900, 0xFFCC33, 0x33CCCC, 0x0099CC];
		
		private var mTemplate:FamilySortTemplate;
		private var mFamilyBoxList:Vector.<Sprite>;
		private var mFamilyList:Vector.<CurvedBox>;
		private var mExampleList:Vector.<CurvedBox>;
		private var mRowList:Vector.<Number>;
		private var mColumnList:Vector.<Number>;
		private var mWordList:Vector.<CurvedBox>;
		private var mDragStartPosition:Point;
		private var mSelectedWord:CurvedBox;
		private var mSelectedWordOrigin:Point;
		private var mSortedWordListList:Vector.<Vector.<CurvedBox>>;
		private var mTargetWordListList:Vector.<Vector.<String>>;
		private var mFamilyLockedList:Vector.<Boolean>;
		private var mBlocker:Sprite;
		private var mSuccessFeedback:Sprite;
		private var mDragTimer:Timer;
		private var mEarFamilyTimer:Timer;
		private var mSuccessFeedbackAudioTimer:Timer;
		private var mCompletedFamily:Vector.<String>;
		
		public function FamilySort(aTemplate:FamilySortTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			var table:Sprite = new Sprite();
			table.graphics.beginFill(Palette.CRAFTING_BOX);
			table.graphics.moveTo(0, 608);;
			table.graphics.lineTo(1024, 608);
			table.graphics.lineTo(1024, 768);
			table.graphics.lineTo(0, 768);
			table.graphics.lineTo(0, 608);
			table.graphics.endFill();
			addChild(table);
			
			var i:int, endi:int;
			var j:int, endj:int;
			
			mFamilyBoxList = new Vector.<Sprite>();
			var familyBox:Sprite;
			var familyBoxBitmap:Bitmap;
			var familyLabel:TextField;
			for (i = 0, endi = Math.min(mTemplate.FamilyList.length, 4); i < endi; ++i)
			{
				familyBox = new Sprite();
				familyBoxBitmap = new Asset.FamilyBoxBitmap[i];
				familyBoxBitmap.x = -familyBoxBitmap.width / 2;
				familyBoxBitmap.y = 0;
				familyBox.addChild(familyBoxBitmap);
				familyLabel = new TextField();
				familyLabel.selectable = false;
				familyLabel.embedFonts = true;
				familyLabel.x = familyBoxBitmap.x;
				familyLabel.y = 120;
				familyLabel.width = familyBoxBitmap.width;
				familyLabel.height = 52.5;
				familyLabel.text = "Family";
				familyLabel.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 52.5, Palette.BTN_CONTENT,
					null, null, null, null, null, TextFormatAlign.CENTER));
				familyBox.addChild(familyLabel);
				familyBox.x = ((i + 1) * ((1024 - (familyBoxBitmap.width * endi)) / (endi + 1))) +
					((i + 0.5) * familyBoxBitmap.width);
				familyBox.y = 0;
				addChild(familyBox);
				mFamilyBoxList.push(familyBox);
			}
			
			mFamilyList = new Vector.<CurvedBox>();
			var familySlot:CurvedBox, familyEmptySlot:CurvedBox;
			var family:CurvedBox;
			for (i = 0, endi = Math.min(mTemplate.FamilyList.length, 4); i < endi; ++i)
			{
				familySlot = new CurvedBox(new Point(180, 76), 0x666666);
				familySlot.x = mFamilyBoxList[i].x;
				familySlot.y = 88;
				addChild(familySlot);
				
				familyEmptySlot = new CurvedBox(new Point(170, 66), 0x555555);
				familyEmptySlot.x = mFamilyBoxList[i].x;
				familyEmptySlot.y = 88;
				addChild(familyEmptySlot);
				
				family = new CurvedBox(new Point(170, 66), Palette.DIALOG_BOX, null, 6);
				family.x = mFamilyBoxList[i].x;
				family.y = 88;
				family.alpha = 0;
				addChild(family);
				mFamilyList.push(family);
			}
			
			var lucu:Bitmap = new Asset.NewCircuitLucuBitmap();
			lucu.x = 758;
			lucu.y = 508;
			addChild(lucu);
			
			mExampleList = new Vector.<CurvedBox>();
			var example:CurvedBox;
			for (i = 0, endi = Math.min(mTemplate.ExampleList.length, 4); i < endi; ++i)
			{
				example = new CurvedBox(new Point(170, 66), Palette.DIALOG_BOX,
					new BoxLabel(mTemplate.ExampleList[i], 52.5, Palette.DIALOG_CONTENT), 6);
				example.x = mFamilyBoxList[i].x;
				example.y = 242;
				example.scaleX = 0.01;
				example.scaleY = 0.01;
				example.alpha = 0;
				example.addEventListener(MouseEvent.CLICK, OnClickExample);
				example.filters = [new GlowFilter(FAMILY_COLOR[i], 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
				addChild(example);
				if (mTemplate.SkipInstruction)
				{
					TweenLite.to(example, 0.5, { ease:Elastic.easeOut, delay:(i * 0.2), scaleX:1, scaleY:1, alpha:1 } );
				}
				else
				{
					TweenLite.to(example, 0.5, { ease:Elastic.easeOut, delay:((i * 0.2) + 0.4), scaleX:1, scaleY:1, alpha:1 } );
				}
				mExampleList.push(example);
			}
			
			mRowList = new Vector.<Number>();
			for (i = 0, endi = 3; i < endi; ++i)
			{
				mRowList.push(242 + ((i + 1) * 96));
			}
			mColumnList = new Vector.<Number>();
			for (i = 0, endi = mFamilyBoxList.length; i < endi; ++i)
			{
				mColumnList.push(mFamilyBoxList[i].x);
			}
			
			mWordList = new Vector.<CurvedBox>();
			var word:CurvedBox;
			for (i = 0, endi = mTemplate.WordList.length; i < endi; ++i)
			{
				word = new CurvedBox(new Point(170, 66), Palette.DIALOG_BOX,
					new BoxLabel(mTemplate.WordList[i], 52.5, Palette.DIALOG_CONTENT), 6);
				word.x = ((i % 4) * 180) + 110;
				word.y = (Math.floor(i / 4) * 76) + 650 + 300;
				if (mTemplate.SkipInstruction)
				{
					TweenLite.to(word, 0.5, { ease:Strong.easeOut, delay:(i * 0.1), y:(word.y - 300) } );
				}
				else
				{
					TweenLite.to(word, 0.5, { ease:Strong.easeOut, delay:((i * 0.1) + 2.8), y:(word.y - 300) } );
				}
				word.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWord);
				word.addEventListener(MouseEvent.CLICK, OnClickWord);
				word.EnableMouseOver();
				addChild(word);
				mWordList.push(word);
			}
			
			mSortedWordListList = new Vector.<Vector.<CurvedBox>>();
			for (i = 0, endi = Math.min(mTemplate.FamilyList.length, 4); i < endi; ++i)
			{
				mSortedWordListList.push(new Vector.<CurvedBox>());
			}
			
			mTargetWordListList = new Vector.<Vector.<String>>();
			for (i = 0, endi = Math.min(mTemplate.FamilyList.length, 4); i < endi; ++i)
			{
				mTargetWordListList.push(new Vector.<String>());
				for (j = 0, endj = mTemplate.WordList.length; j < endj; ++j)
				{
					if (mTemplate.WordList[j].indexOf(mTemplate.FamilyList[i]) > -1)
					{
						mTargetWordListList[i].push(mTemplate.WordList[j]);
					}
				}
			}
			
			mFamilyLockedList = new <Boolean>[false, false, false, false];
			mCompletedFamily = new Vector.<String>();
			
			mBlocker = new Sprite();
			mBlocker.addEventListener(MouseEvent.CLICK, OnClickBlocker);
			mBlocker.graphics.beginFill(0x000000, 0);
			mBlocker.graphics.drawRect(0, 0, 1024, 768);
			mBlocker.graphics.endFill();
			addChild(mBlocker);
			
			var startLessonTimer:Timer = new Timer((mTemplate.WordList.length * 100) + 500, 1);
			if (!mTemplate.SkipInstruction)
			{
				var instruction:Sound = new Asset.FamilyInstructionSound() as Sound;
				instruction.play();
				startLessonTimer.delay = Math.max(startLessonTimer.delay, instruction.length);
			}
			startLessonTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnStartLessonTimerComplete);
			startLessonTimer.start();
			
			mDragTimer = new Timer(1000, 1);
			mDragTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnDragTimerComplete);
			
			mEarFamilyTimer = new Timer(500, 1);
			mEarFamilyTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnEarFamilyTimerComplete);
			
			mSuccessFeedbackAudioTimer = new Timer(1500, 1);
			mSuccessFeedbackAudioTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnSuccessFeedbackAudioTimerComplete);
		}
		
		override public function Dispose():void
		{
			var i:int, endi:int;
			
			for (i = 0, endi = mFamilyBoxList.length; i < endi; ++i)
			{
				mFamilyBoxList[i].removeEventListener(MouseEvent.CLICK, OnClickFamilyBox);
			}
			
			for (i = 0, endi = mFamilyList.length; i < endi; ++i)
			{
				mFamilyList[i].removeEventListener(MouseEvent.CLICK, OnClickFamily);
			}
			
			for (i = 0, endi = mExampleList.length; i < endi; ++i)
			{
				mExampleList[i].removeEventListener(MouseEvent.CLICK, OnClickExample);
			}
			
			for (i = 0, endi = mWordList.length; i < endi; ++i)
			{
				mWordList[i].removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWord);
				mWordList[i].removeEventListener(MouseEvent.CLICK, OnClickWord);
				mWordList[i].removeEventListener(MouseEvent.CLICK, OnClickLockedWord);
			}
			
			mBlocker.removeEventListener(MouseEvent.CLICK, OnClickBlocker);
			
			mEarFamilyTimer.reset();
			mEarFamilyTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnEarFamilyTimerComplete);
			
			mSuccessFeedbackAudioTimer.reset();
			mSuccessFeedbackAudioTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnSuccessFeedbackAudioTimerComplete);
			
			removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			
			super.Dispose();
		}
		
		private function OnStartLessonTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnStartLessonTimerComplete);
			
			removeChild(mBlocker);
		}
		
		private function OnClickBlocker(aEvent:MouseEvent):void
		{
		}
		
		private function OnClickExample(aEvent:MouseEvent):void
		{
			(new Asset.FamilyExampleSound["_" + (aEvent.currentTarget as CurvedBox).Label]() as Sound).play();
		}
		
		private function OnMouseDownWord(aEvent:MouseEvent):void
		{
			if (mSelectedWord)
			{
				mSelectedWord.mouseEnabled = true;
				mSelectedWord.mouseChildren = true;
				mSelectedWord.EnableMouseOver();
				mSelectedWord.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWord);
				mSelectedWord.addEventListener(MouseEvent.CLICK, OnClickWord);
				mSelectedWord.filters = [];
				
				TweenLite.to(mSelectedWord, 0.7, { ease:Elastic.easeOut, x:mSelectedWordOrigin.x, y:mSelectedWordOrigin.y });
				
				mSelectedWord = null;
			}
			
			mSelectedWord = aEvent.currentTarget as CurvedBox;
			mSelectedWord.DisableMouseOver();
			mSelectedWord.filters = [new GlowFilter(Palette.WRONG_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
			
			mSelectedWordOrigin = DisplayObjectUtil.GetPosition(mSelectedWord);
			
			(new Asset.ClickSound() as Sound).play();
			
			(new Asset.FamilyWordSound["_" + mSelectedWord.Label]() as Sound).play();
			
			addEventListener(MouseEvent.MOUSE_MOVE, OnDragMouseMove);
			
			mDragStartPosition = MouseUtil.PositionRelativeTo(this);
			
			mDragTimer.reset();
			mDragTimer.start();
		}
		
		private function OnDragMouseMove(aEvent:MouseEvent):void
		{
			if (MouseUtil.PositionRelativeTo(this).subtract(mDragStartPosition).length > 10)
			{
				mDragTimer.reset();
				
				removeEventListener(MouseEvent.MOUSE_MOVE, OnDragMouseMove);
				mSelectedWord.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWord);
				mSelectedWord.removeEventListener(MouseEvent.CLICK, OnClickWord);
				
				for (var i:int = 0, endi:int = mFamilyBoxList.length; i < endi; ++i)
				{
					if (!mFamilyLockedList[i])
					{
						mFamilyBoxList[i].removeEventListener(MouseEvent.CLICK, OnClickFamilyBox);
					}
				}
				
				TweenLite.to(mSelectedWord, 0.5, { ease:Quad.easeOut, x:mouseX, y:mouseY });
				
				addChild(mSelectedWord);
				
				addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
				addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			}
		}
		
		private function OnDragTimerComplete(aEvent:TimerEvent):void
		{
			mDragTimer.reset();
			
			removeEventListener(MouseEvent.MOUSE_MOVE, OnDragMouseMove);
			mSelectedWord.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWord);
			mSelectedWord.removeEventListener(MouseEvent.CLICK, OnClickWord);
			
			for (var i:int = 0, endi:int = mFamilyBoxList.length; i < endi; ++i)
			{
				if (!mFamilyLockedList[i])
				{
					mFamilyBoxList[i].removeEventListener(MouseEvent.CLICK, OnClickFamilyBox);
				}
			}
			
			TweenLite.to(mSelectedWord, 0.5, { ease:Quad.easeOut, x:mouseX, y:mouseY });
			
			addChild(mSelectedWord);
			
			addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
		}
		
		private function OnMouseUp(aEvent:MouseEvent):void
		{
			if (!mSelectedWord)
			{
				return;
			}
			
			addChild(mBlocker);
			
			removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			removeEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			
			var familyIndex:int = -1;
			
			var i:int, endi:int;
			for (i = 0, endi = mFamilyBoxList.length; i < endi; ++i)
			{
				if (!mFamilyLockedList[i] && mSortedWordListList[i].length < 3 &&
					mSortedWordListList[i].indexOf(mSelectedWord) == -1)
				{
					if (mFamilyBoxList[i].getBounds(this).containsPoint(MouseUtil.PositionRelativeTo(this)))
					{
						familyIndex = i;
						break;
					}
				}
			}
			
			if (familyIndex > -1)
			{
				mSortedWordListList[familyIndex].push(mSelectedWord);
				var wordIndex:int = mSortedWordListList[familyIndex].length - 1;
				
				if (mSelectedWord.Label.indexOf(mTemplate.FamilyList[familyIndex]) > -1)
				{
					mSelectedWord.addEventListener(MouseEvent.CLICK, OnClickLockedWord);
					mSelectedWord.filters = [new GlowFilter(FAMILY_COLOR[familyIndex], 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
				}
				else
				{
					mSelectedWord.EnableMouseOver();
					mSelectedWord.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWord);
					mSelectedWord.addEventListener(MouseEvent.CLICK, OnClickWord);
					mSelectedWord.filters = [];
				}
				
				var index:int;
				for (i = 0, endi = mSortedWordListList.length; i < endi; ++i)
				{
					if (i != familyIndex)
					{
						index = mSortedWordListList[i].indexOf(mSelectedWord);
						if (index > -1)
						{
							mSortedWordListList[i].splice(index, 1);
							for (var j:int = index, endj:int = mSortedWordListList[i].length; j < endj; ++j)
							{
								TweenLite.to(mSortedWordListList[i][j], 0.5, { ease:Elastic.easeOut, y:mRowList[j] });
							}
							break;
						}
					}
				}
				
				TweenLite.to(mSelectedWord, 0.7, { ease:Elastic.easeOut, onComplete:OnTweenSortWord,
					onCompleteParams:[familyIndex, wordIndex], x:mColumnList[familyIndex], y:mRowList[wordIndex] });
				
				(new Asset.SlideSound() as Sound).play();
			}
			else
			{
				mSelectedWord.EnableMouseOver();
				mSelectedWord.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWord);
				mSelectedWord.addEventListener(MouseEvent.CLICK, OnClickWord);
				mSelectedWord.filters = [];
				
				TweenLite.to(mSelectedWord, 0.7, { ease:Elastic.easeOut, x:mSelectedWordOrigin.x, y:mSelectedWordOrigin.y });
				
				(new Asset.SlideSound() as Sound).play();
				
				removeChild(mBlocker);
			}
			
			mSelectedWord.mouseEnabled = true;
			mSelectedWord.mouseChildren = true;
			mSelectedWord = null;
		}
		
		private function OnClickWord(aEvent:MouseEvent):void
		{
			if (!mSelectedWord)
			{
				return;
			}
			
			mDragTimer.reset();
			
			TweenLite.to(mSelectedWord, 0.5, { ease:Quad.easeOut, x:mouseX, y:mouseY });
			
			for (var i:int = 0, endi:int = mFamilyBoxList.length; i < endi; ++i)
			{
				if (!mFamilyLockedList[i])
				{
					if (!mFamilyBoxList[i].hasEventListener(MouseEvent.CLICK))
					{
						mFamilyBoxList[i].addEventListener(MouseEvent.CLICK, OnClickFamilyBox);
					}
				}
			}
			
			mSelectedWord.mouseEnabled = false;
			mSelectedWord.mouseChildren = false;
			mSelectedWord.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWord);
			mSelectedWord.removeEventListener(MouseEvent.CLICK, OnClickWord);
			removeEventListener(MouseEvent.MOUSE_MOVE, OnDragMouseMove);
			
			addChild(mSelectedWord);
			addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
		}
		
		private function OnMouseMove(aEvent:MouseEvent):void
		{
			TweenLite.to(mSelectedWord, 0.5, { ease:Quad.easeOut, x:mouseX, y:mouseY });
		}
		
		private function OnClickLockedWord(aEvent:MouseEvent):void
		{
			(new Asset.FamilyWordSound["_" + (aEvent.currentTarget as CurvedBox).Label]() as Sound).play();
		}
		
		private function OnClickFamilyBox(aEvent:MouseEvent):void
		{
			addChild(mBlocker);
			
			removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			
			var familyIndex:int = mFamilyBoxList.indexOf(aEvent.currentTarget as Sprite);
			
			var i:int, endi:int;
			
			if (mSortedWordListList[familyIndex].indexOf(mSelectedWord) > -1)
			{
				mSelectedWord.EnableMouseOver();
				mSelectedWord.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWord);
				mSelectedWord.addEventListener(MouseEvent.CLICK, OnClickWord);
				mSelectedWord.filters = [];
				
				TweenLite.to(mSelectedWord, 0.7, { ease:Elastic.easeOut, x:mSelectedWordOrigin.x, y:mSelectedWordOrigin.y });
				
				(new Asset.SlideSound() as Sound).play();
				
				removeChild(mBlocker);
			}
			else if (mSortedWordListList[familyIndex].length < 3)
			{
				mSortedWordListList[familyIndex].push(mSelectedWord);
				var wordIndex:int = mSortedWordListList[familyIndex].length - 1;
				
				if (mSelectedWord.Label.indexOf(mTemplate.FamilyList[familyIndex]) > -1)
				{
					mSelectedWord.addEventListener(MouseEvent.CLICK, OnClickLockedWord);
					mSelectedWord.filters = [new GlowFilter(FAMILY_COLOR[familyIndex], 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
				}
				else
				{
					mSelectedWord.EnableMouseOver();
					mSelectedWord.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWord);
					mSelectedWord.addEventListener(MouseEvent.CLICK, OnClickWord);
					mSelectedWord.filters = [];
				}
				
				var index:int;
				for (i = 0, endi = mSortedWordListList.length; i < endi; ++i)
				{
					if (i != familyIndex)
					{
						index = mSortedWordListList[i].indexOf(mSelectedWord);
						if (index > -1)
						{
							mSortedWordListList[i].splice(index, 1);
							for (var j:int = index, endj:int = mSortedWordListList[i].length; j < endj; ++j)
							{
								TweenLite.to(mSortedWordListList[i][j], 0.5, { ease:Elastic.easeOut, y:mRowList[j] });
							}
							break;
						}
					}
				}
				
				TweenLite.to(mSelectedWord, 0.7, { ease:Elastic.easeOut, onComplete:OnTweenSortWord,
					onCompleteParams:[familyIndex, wordIndex], x:mColumnList[familyIndex], y:mRowList[wordIndex] });
				
				(new Asset.SlideSound() as Sound).play();
			}
			else
			{
				mSelectedWord.EnableMouseOver();
				mSelectedWord.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWord);
				mSelectedWord.addEventListener(MouseEvent.CLICK, OnClickWord);
				mSelectedWord.filters = [];
				
				TweenLite.to(mSelectedWord, 0.7, { ease:Elastic.easeOut, x:mSelectedWordOrigin.x, y:mSelectedWordOrigin.y });
				
				(new Asset.SlideSound() as Sound).play();
				
				removeChild(mBlocker);
			}
			
			for (i = 0, endi = mFamilyBoxList.length; i < endi; ++i)
			{
				mFamilyBoxList[i].removeEventListener(MouseEvent.CLICK, OnClickFamilyBox);
			}
			
			mSelectedWord.mouseEnabled = true;
			mSelectedWord.mouseChildren = true;
			mSelectedWord = null;
		}
		
		private function OnTweenSortWord(aFamilyIndex:int, aWordIndex:int):void
		{
			var valid:Boolean, newFamilyLock:int;
			var i:int, endi:int;
			var j:int, endj:int;
			var k:int, endk:int;
			
			for (i = 0, endi = mTargetWordListList.length; i < endi; ++i)
			{
				valid = true;
				for (j = 0, endj = mTargetWordListList[i].length; j < endj && valid; ++j)
				{
					valid = false;
					for (k = 0, endk = mSortedWordListList[i].length; k < endk && !valid; ++k)
					{
						if (mSortedWordListList[i][k].Label == mTargetWordListList[i][j])
						{
							valid = true;
						}
					}
				}
				if (valid && mTargetWordListList[i].length == mSortedWordListList[i].length && !mFamilyLockedList[i])
				{
					++newFamilyLock;
					
					mFamilyBoxList[i].removeEventListener(MouseEvent.CLICK, OnClickFamilyBox);
					mFamilyLockedList[i] = true;
					
					mFamilyList[i].BoxColor = Palette.DIALOG_BOX;
					mFamilyList[i].Content = new BoxLabel(mTemplate.FamilyList[i], 52.5, Palette.DIALOG_CONTENT);
					mFamilyList[i].scaleX = mFamilyList[i].scaleY = 0.01;
					mFamilyList[i].addEventListener(MouseEvent.CLICK, OnClickFamily);
					TweenLite.to(mFamilyList[i], 0.5, { ease:Elastic.easeOut, delay:(newFamilyLock * 0.5),
						scaleX:1, scaleY:1, alpha:1 });
					
					mCompletedFamily.push(mTemplate.FamilyList[i]);
				}
			}
			
			if (newFamilyLock)
			{
				(new (Random.FromList(Asset.PositiveFeedbackSound) as Class)() as Sound).play();
				
				mEarFamilyTimer.start();
			}
			else
			{
				removeChild(mBlocker);
			}
			
			if (mFamilyLockedList.indexOf(false) == -1)
			{
				mSuccessFeedback = new Sprite();
				mSuccessFeedback.addEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
				mSuccessFeedback.graphics.beginFill(0x000000, 0);
				mSuccessFeedback.graphics.drawRect(0, 0, 1024, 768);
				mSuccessFeedback.graphics.endFill();
				mSuccessFeedback.alpha = 0;
				
				var successLabel:TextField = new TextField();
				successLabel.autoSize = TextFieldAutoSize.CENTER;
				successLabel.selectable = false;
				successLabel.filters = [new DropShadowFilter(1.5, 45, 0x000000, 1, 2, 2, 3, BitmapFilterQuality.HIGH)];
				successLabel.text = "Great!\nClick to continue.";
				successLabel.embedFonts = true;
				successLabel.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 72,
					Result.GREAT.Color, null, null, null, null, null, TextFormatAlign.CENTER));
				successLabel.x = 512 - (successLabel.width / 2);
				successLabel.y = 384 - (successLabel.height / 2);
				
				var successBox:CurvedBox = new CurvedBox(new Point(successLabel.width + 24, successLabel.height), Palette.DIALOG_BOX);
				successBox.alpha = 0.7;
				successBox.x = 512;
				successBox.y = 384;
				
				mSuccessFeedback.addChild(successBox);
				mSuccessFeedback.addChild(successLabel);
				addChild(mSuccessFeedback);
				TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, delay:2.2,
					onComplete:OnTweenShowSuccessFeedback, alpha:1 });
				
				mSuccessFeedbackAudioTimer.reset();
				mSuccessFeedbackAudioTimer.start();
			}
		}
		
		private function OnClickFamily(aEvent:MouseEvent):void
		{
			(new Asset.FamilySound["_" + (aEvent.currentTarget as CurvedBox).Label]() as Sound).play();
		}
		
		private function OnEarFamilyTimerComplete(aEvent:TimerEvent):void
		{
			mEarFamilyTimer.reset();
			
			(new Asset.FamilySound["_" + mCompletedFamily.shift()]() as Sound).play();
			
			if (mCompletedFamily.length)
			{
				mEarFamilyTimer.start();
			}
			else if (!mSuccessFeedback)
			{
				removeChild(mBlocker);
			}
		}
		
		private function OnSuccessFeedbackAudioTimerComplete(aEvent:TimerEvent):void
		{
			mSuccessFeedbackAudioTimer.reset();
			
			(new Asset.CrescendoSound() as Sound).play();
		}
		
		private function OnTweenShowSuccessFeedback():void
		{
			removeChild(mBlocker);
			
			(new Asset.ClickToContinueSound() as Sound).play();
		}
		
		private function OnClickSuccessFeedback(aEvent:MouseEvent):void
		{
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideSuccessFeedback, alpha:0 });
		}
		
		private function OnTweenHideSuccessFeedback():void
		{
			TweenLite.killTweensOf(mSuccessFeedback);
			mSuccessFeedback.removeEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			removeChild(mSuccessFeedback);
			mSuccessFeedback = null;
			
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}