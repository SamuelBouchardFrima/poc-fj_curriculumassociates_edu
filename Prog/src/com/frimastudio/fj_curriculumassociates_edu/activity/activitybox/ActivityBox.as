package com.frimastudio.fj_curriculumassociates_edu.activity.activitybox
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentencedecrypting.EncryptedWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentencedecrypting.SentenceDecryptingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentenceunscrambling.MisplacedWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentenceunscrambling.SentenceUnscramblingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordcrafting.EmptyWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordcrafting.WordCraftingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling.ScrambledWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling.WordUnscramblingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
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
	import com.frimastudio.fj_curriculumassociates_edu.util.Geometry;
	import com.frimastudio.fj_curriculumassociates_edu.util.MathUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.MouseUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.StringUtil;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
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
	
	public class ActivityBox extends Box
	{
		private var mWordTemplateList:Vector.<WordTemplate>;
		private var mQuestStep:QuestStepTemplate;
		private var mLineBreakList:Vector.<int>;
		private var mSentenceVO:Class;
		private var mGhostContent:Boolean;
		private var mLaunchingActivity:Boolean;
		private var mWholeBoxClickable:Boolean;
		//private var mHint:Class;
		private var mMegaphoneBtn:CurvedBox;
		private var mHintBtn:CurvedBox;
		private var mWordList:Vector.<Sprite>;
		private var mChunkListList:Vector.<Vector.<CurvedBox>>;
		private var mPunctuationList:Object;
		private var mActivityElement:Sprite;
		private var mActivityTray:PieceTray;
		private var mDraggedPiece:Piece;
		private var mPreviousPosition:Piece;
		private var mSubmitBtn:CurvedBox;
		private var mCurrentActivityIndex:int;
		private var mActivityWorkArea:CurvedBox;
		
		public function get WordTemplateList():Vector.<WordTemplate>	{ return mWordTemplateList; }
		public function set WordTemplateList(aValue:Vector.<WordTemplate>):void	{ mWordTemplateList = aValue; }
		
		public function get StepTemplate():QuestStepTemplate	{ return mQuestStep; }
		public function set StepTemplate(aValue:QuestStepTemplate):void	{ mQuestStep = aValue; }
		
		public function get CurrentActivityCenter():Point
		{
			var thisPosition:Point = DisplayObjectUtil.GetPosition(this);
			var contentPosition:Point = DisplayObjectUtil.GetPosition(mContent);
			
			if (mActivityElement)
			{
				return thisPosition.add(contentPosition).add(DisplayObjectUtil.GetPosition(mActivityElement));
			}
			
			//return thisPosition.add(contentPosition);
			
			//for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
			//{
				//if (mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE)
				//{
					//return thisPosition.add(contentPosition).add(DisplayObjectUtil.GetPosition(mWordList[i]));
				//}
			//}
			
			//throw new Error("Could not find a word with a corresponding activity. Use SentenceCenter instead.");
			return SentenceCenter;
		}
		
		public function get CurrentActivityEmptySlot():Point
		{
			var activityCenter:Point = CurrentActivityCenter;
			if (mActivityTray)
			{
				activityCenter.x += mActivityTray.FirstEmptySlotPosition;
			}
			return activityCenter;
		}
		
		public function GetSlotPosition(aSlot:int):Point
		{
			var slotPosition:Point = CurrentActivityCenter;
			slotPosition.x += mActivityTray.GetSlotPosition(aSlot);
			return slotPosition;
		}
		
		public function set NextEmptySlotValue(aValue:String):void
		{
			var emptyWord:EmptyWordTemplate = mWordTemplateList[mCurrentActivityIndex] as EmptyWordTemplate;
			var index:int = mActivityTray.NextEmptySlotIndex;
			var value:String = aValue;
			if (StringUtil.CharIsUpperCase(emptyWord.Answer.charAt(index)) &&
				StringUtil.CharIsLowerCase(value))
			{
				value = value.toUpperCase();
			}
			else if (StringUtil.CharIsLowerCase(emptyWord.Answer.charAt(index)) &&
				StringUtil.CharIsUpperCase(value))
			{
				value = value.toLowerCase();
			}
			mActivityTray.FirstEmptySlotValue = value;
			
			if (!mActivityTray.HasEmptySlot)
			{
				if (mWordTemplateList[mCurrentActivityIndex].ActivityToLaunch == ActivityType.WORD_CRAFTING)
				{
					var scrambledWord:ScrambledWordTemplate = new ScrambledWordTemplate(emptyWord.Answer,
						mActivityTray.AssembleWord(), emptyWord.Punctuation);
					mWordTemplateList[mCurrentActivityIndex] = scrambledWord;
					
					mActivityTray.BoxColor = ActivityType.WORD_UNSCRAMBLING.ColorCode;
					
					mSubmitBtn = new CurvedBox(new Point(64, 64), Palette.GREAT_BTN,
						new BoxIcon(Asset.IconOKBitmap, Palette.BTN_CONTENT), 6);
					var contentWidth:Number = mActivityTray.Bounds.width + 20 + mSubmitBtn.width;
					mSubmitBtn.x = (contentWidth / 2) - (mSubmitBtn.width / 2);
					mSubmitBtn.y = 0;
					mSubmitBtn.addEventListener(MouseEvent.CLICK, OnClickScrambledWordSubmitBtn);
					mActivityElement.addChild(mSubmitBtn);
					
					mActivityTray.x = -(contentWidth / 2);
					mActivityWorkArea.Size = new Point(contentWidth + 20, mActivityWorkArea.Size.y);;
					
					UpdateContent();
					
					dispatchEvent(new ActivityBoxEvent(ActivityBoxEvent.CHANGE_ACTIVITY_TYPE));
				}
			}
		}
		
		public function SlotListForLetter(aLetter:String):Vector.<Point>
		{
			//var amount:int = 0;
			var slotList:Vector.<Point> = new Vector.<Point>();
			var encryptedWord:EncryptedWordTemplate;
			var word:String;
			var index:int;
			var slot:Point;
			for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
			{
				if (mWordTemplateList[i].ActivityToLaunch == ActivityType.SENTENCE_DECRYPTING)
				{
					encryptedWord = mWordTemplateList[i] as EncryptedWordTemplate;
					word = encryptedWord.ChunkList.join("");
					index = word.indexOf("_");
					while (index != -1)
					{
						if (encryptedWord.Answer.charAt(index).toLowerCase() == aLetter)
						{
							//++amount;
							slot = Geometry.RectangleCenter(mChunkListList[i][0].BoundaryOfLabelCharacter(index));
							slot = slot.add(DisplayObjectUtil.GetPosition(mChunkListList[i][0]));
							slot = slot.add(DisplayObjectUtil.GetPosition(mWordList[i]));
							slot = slot.add(DisplayObjectUtil.GetPosition(mContent));
							slot = slot.add(DisplayObjectUtil.GetPosition(this));
							
							//position = DisplayObjectUtil.GetPosition(mDraggedPiece);
							//position = position.subtract(DisplayObjectUtil.GetPosition(mContent));
							slotList.push(slot);
						}
						index = word.indexOf("_", index + 1);
					}
				}
			}
			//return amount;
			return slotList;
		}
		
		//public function CenterForLetterSlot(aLetter:String, aSlot:int):Point
		//{
			//var center:Point;
			//for (var i:int = 0, endi:int = AmountRequiredForLetter(aLetter); i < endi; ++i)
			//{
				//
			//}
		//}
		
		public function DecryptSentence(aLetter:String):Boolean
		//public function DecryptCharacter(aLetter:String, aSlot:int):Boolean
		{
			var effective:Boolean;
			var encryptedWord:EncryptedWordTemplate;
			var word:String;
			var wordCompleted:Boolean;
			var index:int;
			for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
			{
				if (mWordTemplateList[i].ActivityToLaunch == ActivityType.SENTENCE_DECRYPTING)
				{
					encryptedWord = mWordTemplateList[i] as EncryptedWordTemplate;
					word = encryptedWord.ChunkList.join("");
					wordCompleted = true;
					index = word.indexOf("_");
					while (index != -1)
					{
						if (encryptedWord.Answer.charAt(index).toLowerCase() == aLetter)
						{
							//encryptedWord.ChunkList[index] = aLetter;
							encryptedWord.ChunkList[0] = word.substring(0, index) + encryptedWord.Answer.charAt(index) +
								word.substring(index + 1);
							word = encryptedWord.ChunkList.join("");
							effective = true;
						}
						else
						{
							wordCompleted = false;
						}
						index = word.indexOf("_", index + 1);
					}
					if (wordCompleted)
					{
						encryptedWord.ChunkList = new <String>[encryptedWord.Answer];
						encryptedWord.ActivityToLaunch = ActivityType.NONE;
						encryptedWord.ColorCode = ActivityType.NONE.ColorCode;
						encryptedWord.ProgressDone = true;
					}
				}
			}
			UpdateContent();
			return effective;
		}
		
		public function get SentenceDecryptionFinished():Boolean
		{
			var encryptedWord:EncryptedWordTemplate;
			for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
			{
				if (mWordTemplateList[i].ActivityToLaunch == ActivityType.SENTENCE_DECRYPTING)
				{
					encryptedWord = mWordTemplateList[i] as EncryptedWordTemplate;
					if (encryptedWord.ChunkList.join("") != encryptedWord.Answer)
					{
						return false;
					}
				}
			}
			return true;
		}
		
		public function get SentenceDecrypted():Boolean
		{
			if (!SentenceDecryptionFinished)
			{
				return false;
			}
			
			var encryptedWord:EncryptedWordTemplate;
			for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
			{
				if (mWordTemplateList[i].ActivityToLaunch == ActivityType.SENTENCE_DECRYPTING)
				{
					encryptedWord = mWordTemplateList[i] as EncryptedWordTemplate;
					if (encryptedWord.ChunkList.join("").indexOf("_") > -1)
					{
						return false;
					}
				}
			}
			
			return true;
		}
		
		public function get SentenceScrambled():Boolean
		{
			for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
			{
				if (mWordTemplateList[i].ActivityToLaunch == ActivityType.SENTENCE_UNSCRAMBLING)
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function get SentenceCenter():Point
		{
			var thisPosition:Point = DisplayObjectUtil.GetPosition(this);
			var contentPosition:Point = DisplayObjectUtil.GetPosition(mContent);
			
			var sentenceBounds:Rectangle = mWordList[0].getBounds(mContent);
			for (var i:int = 0, endi:int = mLineBreakList.length; i < endi; ++i)
			{
				sentenceBounds = sentenceBounds.union(mWordList[mLineBreakList[i] - 1].getBounds(mContent));
			}
			sentenceBounds = sentenceBounds.union(mWordList[mWordList.length - 1].getBounds(mContent));
			
			//var offset:Point = new Point(mContent.width / 2);
			//return thisPosition.add(contentPosition).add(Geometry.RectangleCenter(sentenceBounds)).add(offset);
			return thisPosition.add(contentPosition).add(Geometry.RectangleCenter(sentenceBounds));
		}
		
		public function get IsComplete():Boolean
		{
			for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
			{
				switch (mWordTemplateList[i].ActivityToLaunch)
				{
					case ActivityType.WORD_UNSCRAMBLING:
					case ActivityType.WORD_CRAFTING:
						return false;
					case ActivityType.SENTENCE_DECRYPTING:
						return SentenceDecryptionFinished;
					default:
						break;
				}
			}
			return true;
		}
		
		public function IsCharacterRequired(aChar:String):Boolean
		{
			var emptyWord:EmptyWordTemplate = mWordTemplateList[mCurrentActivityIndex] as EmptyWordTemplate;
			if (!emptyWord)
			{
				return false;
			}
			
			var expectedAmount:int = emptyWord.Answer.split(aChar).length - 1;
			//var actualAmount:int = emptyWord.ChunkList.join("").split(aChar).length - 1;
			var actualAmount:int = mActivityTray.AssembleWord().split(aChar).length - 1;
			return actualAmount < expectedAmount;
		}
		
		public function ActivityBox(aWordTemplateList:Vector.<WordTemplate>, aLineBreakList:Vector.<int>, aSentenceVO:Class, aPhylacteryArrow:Direction, aGhostContent:Boolean = false, aLaunchingActivity:Boolean = false, aHint:Class = null)
		{
			mWordTemplateList = aWordTemplateList;
			mLineBreakList = (aLineBreakList ? aLineBreakList : new Vector.<int>());
			mSentenceVO = aSentenceVO;
			mGhostContent = aGhostContent;
			mLaunchingActivity = aLaunchingActivity;
			mWholeBoxClickable = false;
			//mHint = aHint;
			
			mWordList = new Vector.<Sprite>();
			mChunkListList = new Vector.<Vector.<CurvedBox>>();
			
			super(new Point(1004, ((mLineBreakList.length + 1) * 80) + 40), Palette.DIALOG_BOX, null, 0, aPhylacteryArrow);
			
			//mContent.x = -382;
			mContent.x = -472;
			
			//if (mLaunchingActivity)
			//{
			//mWholeBoxClickable = true;
			//for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
			//{
			//if (mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE)
			//{
			//mWholeBoxClickable = false;
			//break;
			//}
			//}
			//}
			
			//if (mWholeBoxClickable)
			//{
			//addEventListener(MouseEvent.CLICK, OnClick);
			//
			//mMegaphoneBtn = new CurvedBox(new Point(80, 80), 0x999999, new BoxIcon(Asset.IconEarBitmap, Palette.BTN_CONTENT));
			//mMegaphoneBtn.x = -442;
			//mMegaphoneBtn.y = 0;
			//addChild(mMegaphoneBtn);
			//}
			//else
			//{
			mMegaphoneBtn = new CurvedBox(new Point(64, 64), Palette.GREAT_BTN,
				new BoxIcon(Asset.IconEarBitmap, Palette.BTN_CONTENT), 6);
			mMegaphoneBtn.x = 442;
			//mMegaphoneBtn.y = -42;
			mMegaphoneBtn.y = 0;
			mMegaphoneBtn.addEventListener(MouseEvent.CLICK, OnClickMegaphoneBtn);
			addChild(mMegaphoneBtn);
			
			//mHintBtn = new CurvedBox(new Point(64, 64), Palette.TOOL_BOX,
				//new BoxIcon(Asset.IconHintBitmap, Palette.BTN_CONTENT), 6);
			//mHintBtn.x = 442;
			//mHintBtn.y = 42;
			//mHintBtn.addEventListener(MouseEvent.CLICK, OnClickHintBtn);
			//addChild(mHintBtn);
			//}
			//
			//if (mHint)
			//{
			//mHintBtn = new CurvedBox(new Point(80, 80), Palette.VALID_BTN, new BoxLabel("?", 60, Palette.BTN_CONTENT), 3);
			//mHintBtn.x = 442;
			//mHintBtn.y = 0;
			//mHintBtn.addEventListener(MouseEvent.CLICK, OnClickHintBtn);
			//addChild(mHintBtn);
			//}
			//else
			//{
			//mHintBtn = new CurvedBox(new Point(80, 80), 0x999999, new BoxLabel("?", 60, Palette.BTN_CONTENT), 3);
			//mHintBtn.x = 442;
			//mHintBtn.y = 0;
			//addChild(mHintBtn);
			//}
		}
		
		public function Dispose():void
		{
			for (var i:int = 0, endi:int = mWordList.length; i < endi; ++i)
			{
				TweenLite.killTweensOf(mWordList[i]);
				mWordList[i].removeEventListener(MouseEvent.CLICK, OnClickWordAudio);
				mWordList[i].removeEventListener(MouseEvent.CLICK, OnClickWord);
			}
			
			//removeEventListener(MouseEvent.CLICK, OnClick);
			mMegaphoneBtn.removeEventListener(MouseEvent.CLICK, OnClickMegaphoneBtn);
			//mHintBtn.removeEventListener(MouseEvent.CLICK, OnClickHintBtn);
		}
		
		public function UpdateCurrentActivityContent(aChunkList:Vector.<String>, aGhostContent:Boolean = false, aOneWord:Boolean = true):void
		{
			mGhostContent = aGhostContent;
			
			var i:int, endi:int;
			var j:int, endj:int;
			if (aOneWord)
			{
				for (i = 0, endi = mWordTemplateList.length; i < endi; ++i)
				{
					if (mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE)
					{
						for (j = 0, endj = mWordTemplateList[i].ChunkList.length; j < endj; ++j)
						{
							mWordTemplateList[i].ChunkList[j] = (j < aChunkList.length ? aChunkList[j] : " ");
						}
						if (i == 0)
						{
							mWordTemplateList[0].ChunkList[0] = mWordTemplateList[0].ChunkList[0].charAt(0).toUpperCase() + mWordTemplateList[0].ChunkList[0].substring(1, mWordTemplateList[0].ChunkList[0].length);
						}
						UpdateContent(false);
						return;
					}
				}
			}
			else
			{
				var chunkList:Vector.<String>;
				for (i = 0, endi = mWordTemplateList.length; i < endi; ++i)
				{
					mWordTemplateList[i].ChunkList[0] = (i < aChunkList.length ? aChunkList[i] : " ");
				}
				UpdateContent(false);
			}
		}
		
		public function ProgressWord(aIndex:int):void
		{
			if (mWordTemplateList[aIndex].ActivityToLaunch != ActivityType.NONE)
			{
				mWordTemplateList[aIndex].ActivityToLaunch = ActivityType.NONE;
				mWordTemplateList[aIndex].ColorCode = ActivityType.NONE.ColorCode;
				mWordTemplateList[aIndex].ProgressDone = true;
				mWordTemplateList[aIndex].ChunkList = new <String>[mWordTemplateList[aIndex].ChunkList.join("")];
					//UpdateContent();
			}
		}
		
		public function ProgressCurrentActivity():void
		{
			for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
			{
				if (mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE)
				{
					mWordTemplateList[i].ActivityToLaunch = ActivityType.NONE;
					mWordTemplateList[i].ColorCode = ActivityType.NONE.ColorCode;
					mWordTemplateList[i].ProgressDone = true;
					mWordTemplateList[i].ChunkList = new <String>[mWordTemplateList[i].ChunkList.join("")];
				}
			}
			UpdateContent(false);
		}
		
		override protected function DrawContent():void
		{
			while (mContent.numChildren)
			{
				mContent.removeChildAt(0);
			}
			mWordList.splice(0, mWordList.length);
			mChunkListList.splice(0, mChunkListList.length);
			mPunctuationList = {};
			
			var i:int, endi:int;
			var j:int, endj:int;
			//var wordTweenList:Vector.<TweenLite> = new Vector.<TweenLite>();
			var wordTweenList:Vector.<Sprite> = new Vector.<Sprite>();
			var word:Sprite;
			var wordOffset:Point = new Point();
			var chunkList:Vector.<CurvedBox>;
			var chunk:CurvedBox;
			var chunkOffset:Number;
			var label:String;
			var labelColor:int;
			var punctuation:TextField;
			
			for (i = 0, endi = mWordTemplateList.length; i < endi; ++i)
			{
				word = new Sprite();
				chunkList = new Vector.<CurvedBox>();
				chunkOffset = 0;
				for (j = 0, endj = mWordTemplateList[i].ChunkList.length; j < endj; ++j)
				{
					label = mWordTemplateList[i].ChunkList[j];
					labelColor = Palette.DIALOG_CONTENT;
					switch (label)
					{
						case "_": 
							label = " ";
							labelColor = mWordTemplateList[i].ColorCode;
							break;
					}
					chunk = new CurvedBox(new Point(60, 60), mWordTemplateList[i].ColorCode,
						new BoxLabel(label, 45, labelColor), 6, null, Axis.HORIZONTAL);
					chunk.ColorBorderOnly = true;
					chunkOffset += chunk.width / 2;
					chunk.x = chunkOffset;
					chunk.y = 0;
					word.addChild(chunk);
					chunkList.push(chunk);
					
					chunkOffset += (chunk.width / 2);
				}
				
				chunkOffset = -word.width / 2;
				for (j = 0, endj = chunkList.length; j < endj; ++j)
				{
					chunkList[j].x += chunkOffset;
				}
				
				if (mLineBreakList.indexOf(i) > -1)
				{
					wordOffset.x = 0;
					wordOffset.y += word.height + 20;
				}
				
				wordOffset.x += (word.width / 2);
				word.x = wordOffset.x;
				word.y = wordOffset.y + (word.height / 2);
				
				//word.alpha = (mGhostContent && mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE ? 0.5 : 1);
				
				word.graphics.beginFill(0x000000, 0);
				word.graphics.drawRect(-word.width / 2, -word.height / 2, word.width, word.height);
				word.graphics.endFill();
				
				switch (mWordTemplateList[i].ActivityToLaunch)
				{
					case ActivityType.SENTENCE_DECRYPTING: 
					case ActivityType.WORD_UNSCRAMBLING: 
					case ActivityType.WORD_CRAFTING: 
					case ActivityType.SENTENCE_UNSCRAMBLING: 
						if (!mWholeBoxClickable)
						{
							if (mLaunchingActivity)
							{
								word.addEventListener(MouseEvent.CLICK, OnClickWord);
								
								//word.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 16, 16, 2, BitmapFilterQuality.HIGH)];
								//TweenLite.to(word, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowStrong,
								//onCompleteParams:[word], glowFilter: { alpha:0.75 } });
								//wordTweenList.push(TweenLite.to(word, 0.1, { ease:Quad.easeOut, delay:2,
								//onComplete:OnTweenAttentionJump, onCompleteParams:[0, word, word.y], y:(word.y - 25),
								//scaleX:0.9, scaleY:1.1 }));
								wordTweenList.push(word);
							}
							else
							{
								//if (mWordTemplateList[i].ProgressDone)
								//{
									//word.filters = [new GlowFilter(Palette.GREAT_BTN, 1, 2, 2, 4, BitmapFilterQuality.HIGH)];
								//}
								
								word.addEventListener(MouseEvent.CLICK, OnClickWordAudio);
							}
						}
						break;
					case ActivityType.NONE: 
						if (mWordTemplateList[i].ProgressDone)
						{
							word.filters = [new GlowFilter(Palette.GREAT_BTN, 1, 2, 2, 4, BitmapFilterQuality.HIGH)];
						}
						if (!mWholeBoxClickable)
						{
							word.addEventListener(MouseEvent.CLICK, OnClickWordAudio);
						}
					default: 
						break;
				}
				
				mContent.addChild(word);
				mWordList.push(word);
				mChunkListList.push(chunkList);
				wordOffset.x += (word.width / 2);
				
				if (mWordTemplateList[i].Punctuation.length)
				{
					punctuation = new TextField();
					punctuation.embedFonts = true;
					punctuation.selectable = false;
					punctuation.autoSize = TextFieldAutoSize.CENTER;
					punctuation.height = 60;
					punctuation.text = mWordTemplateList[i].Punctuation;
					punctuation.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 45, Palette.DIALOG_CONTENT, null, null, null, null, null, TextFormatAlign.CENTER));
					punctuation.x = wordOffset.x;
					punctuation.y = wordOffset.y;
					mContent.addChild(punctuation);
					mPunctuationList[i] = punctuation;
					
					wordOffset.x += punctuation.width;
				}
				if (mWordTemplateList[i].Punctuation != "'")
				{
					//wordOffset.x += 10;
					wordOffset.x += 15;
				}
			}
			
			//wordOffset = new Point(-mContent.width / 2, -mContent.height / 2);
			wordOffset = new Point(0, -mContent.height / 2);
			for (i = 0, endi = mWordList.length; i < endi; ++i)
			{
				mWordList[i].x += wordOffset.x;
				mWordList[i].y += wordOffset.y;
			}
			for each (punctuation in mPunctuationList)
			{
				punctuation.x += wordOffset.x;
				punctuation.y += wordOffset.y;
			}
			for (i = 0, endi = wordTweenList.length; i < endi; ++i)
			{
				//TweenLite.to(wordTweenList[i], 0.1, {ease: Quad.easeOut, onComplete: OnTweenAttentionJump, onCompleteParams: [0, wordTweenList[i], wordTweenList[i].y], y: (wordTweenList[i].y - 25), scaleX: 0.9, scaleY: 1.1});
			}
		}
		
		public function UpdateContent(aPlayExplosion:Boolean = true):void
		{
			var i:int, endi:int;
			var j:int, endj:int;
			var word:Sprite;
			var wordWidth:Number;
			var wordOffset:Number = 0;
			var chunkList:Vector.<CurvedBox>;
			var chunkTargetList:Vector.<Number>;
			var chunk:CurvedBox;
			var chunkOffset:Number;
			var label:String;
			var labelColor:int;
			var punctuation:TextField;
			//var whiteBox:CurvedBox;
			//var wordExplosion:MovieClip;
			//var colorTransform:ColorTransform;
			//var size:Point;
			var highlight:Sprite;
			var highlightBitmap:Bitmap;
			
			for (i = 0, endi = mWordTemplateList.length; i < endi; ++i)
			{
				word = mWordList[i];
				chunkList = mChunkListList[i];
				chunkTargetList = new Vector.<Number>();
				chunkOffset = 0;
				
				if (mWordTemplateList[i].ProgressDone)
				{
					word.filters = [new GlowFilter(Palette.GREAT_BTN, 1, 2, 2, 4, BitmapFilterQuality.HIGH)];
				}
				
				if (word == mActivityElement)
				{
					chunkOffset = word.width;
				}
				else if (chunkList.length == mWordTemplateList[i].ChunkList.length)
				{
					for (j = 0, endj = mWordTemplateList[i].ChunkList.length; j < endj; ++j)
					{
						label = mWordTemplateList[i].ChunkList[j];
						labelColor = Palette.DIALOG_CONTENT;
						switch (label)
						{
							case "_": 
								label = " ";
								labelColor = mWordTemplateList[i].ColorCode;
								break;
						}
						if (chunkList[j].Label != label)
						{
							chunk = new CurvedBox(new Point(60, 60), mWordTemplateList[i].ColorCode,
								new BoxLabel(label, 45, labelColor), 6, null, Axis.HORIZONTAL);
							chunk.ColorBorderOnly = true;
							chunkOffset += chunk.width / 2;
							chunk.x = chunkList[j].x;
							chunkTargetList.push(chunkOffset);
							chunk.y = 0;
							word.addChild(chunk);
							
							if (aPlayExplosion)
							{
								highlight = new Sprite();
								highlight.mouseEnabled = highlight.mouseChildren = false;
								highlight.x = chunk.x + word.x + mContent.x;
								highlight.y = chunk.y + word.y + mContent.y;
								highlight.scaleX = highlight.scaleY = 0.01;
								highlight.alpha = 0;
								highlightBitmap = new Asset.SubmissionHighlightBitmap() as Bitmap;
								highlightBitmap.smoothing = true;
								highlightBitmap.x = -highlightBitmap.width / 2;
								highlightBitmap.y = -highlightBitmap.height / 2;
								highlight.addChild(highlightBitmap);
								addChild(highlight);
								
								TweenLite.to(highlight, 0.2, {ease: Strong.easeIn, onComplete: OnTweenShowHighlight, onCompleteParams: [highlight], scaleX: 1, scaleY: 1, alpha: 1, rotation: 30});
								
									//chunk.alpha = 0;
									//
									//size = MathUtil.MaxPoint(chunk.Size, chunkList[j].Size);
									//whiteBox = new CurvedBox(size, Palette.GREAT_BTN);
									//whiteBox.x = chunkList[j].x;
									//whiteBox.y = chunkList[j].y;
									//whiteBox.alpha = 0;
									//word.addChild(whiteBox);
									//TweenLite.to(whiteBox, 0.1, { ease:Strong.easeOut, delay:(j * 0.07), onComplete:OnTweenWhitenChunk,
									//onCompleteParams:[chunkList[j], whiteBox, word, chunk], alpha:1 } );
							}
							//else
							//{
							if (word.contains(chunkList[j]))
							{
								word.removeChild(chunkList[j]);
							}
							//}
							
							chunkList[j] = chunk;
							chunkOffset += chunk.width / 2;
						}
						else
						{
							chunkOffset += chunkList[j].width / 2;
							chunkTargetList.push(chunkOffset);
							word.addChild(chunkList[j]);
							chunkOffset += chunkList[j].width / 2;
						}
					}
				}
				else
				{
					chunk = new CurvedBox(new Point(60, 60), mWordTemplateList[i].ColorCode,
						new BoxLabel(mWordTemplateList[i].ChunkList[0], 45, Palette.DIALOG_CONTENT), 6, null, Axis.HORIZONTAL);
					chunk.ColorBorderOnly = true;
					chunkOffset += chunk.width / 2;
					chunk.x = 0;
					chunkTargetList.push(chunkOffset);
					chunk.y = 0;
					word.addChild(chunk);
					//if (mWordTemplateList[i].ProgressDone)
					//{
					//word.filters = [new GlowFilter(Palette.GREAT_BTN, 1, 2, 2, 4, BitmapFilterQuality.HIGH)];
					//}
					
					if (aPlayExplosion)
					{
						highlight = new Sprite();
						highlight.mouseEnabled = highlight.mouseChildren = false;
						highlight.x = chunk.x + word.x + mContent.x;
						highlight.y = chunk.y + word.y + mContent.y;
						highlight.scaleX = highlight.scaleY = 0.01;
						highlight.alpha = 0;
						highlightBitmap = new Asset.SubmissionHighlightBitmap() as Bitmap;
						highlightBitmap.smoothing = true;
						highlightBitmap.x = -highlightBitmap.width / 2;
						highlightBitmap.y = -highlightBitmap.height / 2;
						highlight.addChild(highlightBitmap);
						addChild(highlight);
						
						TweenLite.to(highlight, 0.2, {ease: Strong.easeIn, onComplete: OnTweenShowHighlight, onCompleteParams: [highlight], scaleX: 1, scaleY: 1, alpha: 1, rotation: 30});
						
							//chunk.alpha = 0;
							//
							//for (j = 0, endj = chunkList.length; j < endj; ++j)
							//{
							//whiteBox = new CurvedBox(chunkList[j].Size, Palette.GREAT_BTN);
							//whiteBox.x = chunkList[j].x;
							//whiteBox.y = chunkList[j].y;
							//whiteBox.alpha = 0;
							//word.addChild(whiteBox);
							//TweenLite.to(whiteBox, 0.1, { ease:Strong.easeOut, delay:(j * 0.07), onComplete:OnTweenWhitenChunk,
							//onCompleteParams:[chunkList[j], whiteBox, word, (j == 0 ? chunk : null)], alpha:1 });
							//}
							//
							//if (!wordExplosion)
							//{
							//wordExplosion = new Asset.TrayExplosionClip() as MovieClip;
							//}
					}
					//else
					//{
					for (j = 0, endj = chunkList.length; j < endj; ++j)
					{
						word.removeChild(chunkList[j]);
					}
					
					//word.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 2, 2, 4, BitmapFilterQuality.HIGH)];
					TweenLite.to(word, 0.5, {glowFilter: {alpha: 1}});
					//}
					
					chunkList = mChunkListList[i] = new <CurvedBox>[chunk];
					chunkOffset += chunk.width / 2;
				}
				
				wordWidth = chunkOffset;
				chunkOffset = -wordWidth / 2;
				
				//if (wordExplosion && aPlayExplosion)
				//{
				//(new Asset.TrayExplosionSound() as Sound).play();
				//wordExplosion.x = -wordWidth / 2;
				//wordExplosion.y = 0;
				//colorTransform = new ColorTransform();
				//colorTransform.color = Palette.GREAT_BTN;
				//wordExplosion.transform.colorTransform = colorTransform;
				//word.addChild(wordExplosion);
				//TweenLite.to(this, 1.5, { onComplete:OnTweenHideWordExplosion,
				////onCompleteParams:[wordExplosion, word, chunkList[0]] });
				//onCompleteParams:[wordExplosion, word] });
				//
				//wordExplosion = null;
				//}
				
				for (j = 0, endj = chunkList.length; j < endj; ++j)
				{
					TweenLite.to(chunkList[j], 1, {ease: Elastic.easeOut, x: (chunkTargetList[j] + chunkOffset)});
				}
				
				if (mLineBreakList.indexOf(i) > -1)
				{
					wordOffset = 0;
				}
				
				//wordOffset += word.width / 2;
				wordOffset += wordWidth / 2;
				TweenLite.to(word, 1, {ease: Elastic.easeOut, x: wordOffset});
				
				//word.alpha = (mGhostContent && mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE ? 0.5 : 1);
				
				word.graphics.beginFill(0x000000, 0);
				word.graphics.drawRect(-word.width / 2, -word.height / 2, word.width, word.height);
				word.graphics.endFill();
				
				//wordOffset += word.width / 2;
				wordOffset += wordWidth / 2;
				
				if (mWordTemplateList[i].Punctuation.length)
				{
					TweenLite.to(mPunctuationList[i], 1, {ease: Elastic.easeOut, x: wordOffset});
					wordOffset += mPunctuationList[i].width;
				}
				if (mWordTemplateList[i].Punctuation != "'")
				{
					//wordOffset += 10;
					wordOffset += 15;
				}
			}
		}
		
		public function UseActivityElement(aIndex:int):void
		{
			//mWordTemplateList[aIndex]
			
			mCurrentActivityIndex = aIndex;
			
			mActivityElement = new Sprite();
			mActivityElement.x = mWordList[mCurrentActivityIndex].x;
			mActivityElement.y = mWordList[mCurrentActivityIndex].y;
			
			mActivityWorkArea = new CurvedBox(new Point(80, 80), 0x999999);
			mActivityWorkArea.x = 0;
			mActivityWorkArea.y = 0;
			mActivityElement.addChild(mActivityWorkArea);
			
			var word:String = mWordTemplateList[mCurrentActivityIndex].ChunkList.join("");
			var startWithUppercase:Boolean = false;
			switch (mWordTemplateList[mCurrentActivityIndex].ActivityToLaunch)
			{
				case ActivityType.WORD_CRAFTING:
					var emptyWord:EmptyWordTemplate = mWordTemplateList[mCurrentActivityIndex] as EmptyWordTemplate;
					startWithUppercase = StringUtil.CharIsUpperCase(emptyWord.Answer.charAt(0));
					break;
				case ActivityType.WORD_UNSCRAMBLING:
					var scrambledWord:ScrambledWordTemplate = mWordTemplateList[mCurrentActivityIndex] as ScrambledWordTemplate;
					startWithUppercase = StringUtil.CharIsUpperCase(scrambledWord.Answer.charAt(0));
					break;
				default:
					break;
			}
			
			var i:int, endi:int;
			//var word:String = mWordTemplateList[mCurrentActivityIndex].ChunkList.join("").split(" ").join("_");
			var letterList:Vector.<String> = Vector.<String>(word.split(""));
			mActivityTray = new PieceTray(false, Vector.<String>(word.split("")), startWithUppercase);
			mActivityTray.BoxColor = mWordTemplateList[mCurrentActivityIndex].ActivityToLaunch.ColorCode;
			mActivityTray.x = -mActivityTray.Bounds.width / 2;
			mActivityTray.y = 0;
			mActivityTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedActivityTray);
			mActivityElement.addChild(mActivityTray);
			
			mActivityWorkArea.Size = new Point(mActivityTray.Bounds.width + 20, mActivityWorkArea.Size.y);
			
			if (mWordTemplateList[mCurrentActivityIndex].ActivityToLaunch == ActivityType.WORD_UNSCRAMBLING)
			{
				mSubmitBtn = new CurvedBox(new Point(64, 64), Palette.GREAT_BTN,
					new BoxIcon(Asset.IconOKBitmap, Palette.BTN_CONTENT), 6);
				var contentWidth:Number = mActivityTray.Bounds.width + 20 + mSubmitBtn.width;
				mSubmitBtn.x = (contentWidth / 2) - (mSubmitBtn.width / 2);
				mSubmitBtn.y = 0;
				mSubmitBtn.addEventListener(MouseEvent.CLICK, OnClickScrambledWordSubmitBtn);
				mActivityElement.addChild(mSubmitBtn);
				
				mActivityTray.x = -(contentWidth / 2);
				mActivityWorkArea.Size = new Point(contentWidth + 20, mActivityWorkArea.Size.y);;
			}
			//switch (mWordTemplateList[mCurrentActivityIndex].ActivityToLaunch)
			//{
				//case ActivityType.WORD_UNSCRAMBLING:
					//mSubmitBtn = new CurvedBox(new Point(64, 64), Palette.GREAT_BTN,
						//new BoxIcon(Asset.IconOKBitmap, Palette.BTN_CONTENT), 3);
					//var contentWidth:Number = mActivityTray.Bounds.width + 20 + mSubmitBtn.width;
					//mSubmitBtn.x = (contentWidth / 2) - (mSubmitBtn.width / 2);
					//mSubmitBtn.y = 0;
					//mSubmitBtn.addEventListener(MouseEvent.CLICK, OnClickScrambledWordSubmitBtn);
					//mActivityElement.addChild(mSubmitBtn);
					//
					//mActivityTray.x = -(contentWidth / 2);
					//mActivityWorkArea.Size = new Point(contentWidth + 20, mActivityWorkArea.Size.y);;
					//break;
				//case ActivityType.WORD_CRAFTING:
					//break;
				//default:
					//throw new Error("ActivityType " + mWordTemplateList[mCurrentActivityIndex].ActivityToLaunch.Description + " not supported.");
					//break;
			//}
			
			mContent.addChildAt(mActivityElement, mContent.getChildIndex(mWordList[mCurrentActivityIndex]));
			
			mWordList[mCurrentActivityIndex].removeEventListener(MouseEvent.CLICK, OnClickWordAudio);
			mWordList[mCurrentActivityIndex].removeEventListener(MouseEvent.CLICK, OnClickWord);
			mContent.removeChild(mWordList[mCurrentActivityIndex]);
			
			mWordList[mCurrentActivityIndex] = mActivityElement;
			mChunkListList[mCurrentActivityIndex] = new Vector.<CurvedBox>();
			
			UpdateContent();
		}
		
		public function BounceInSequence():Number
		{
			var i:int, endi:int;
			var indexInLine:int = 0;
			//var target:Number;
			for (i = 0, endi = mWordList.length; i < endi; ++i)
			{
				//if (mLineBreakList.indexOf(i) > -1)
				//{
					//indexInLine = 0;
					//target = mWordList[i].x;
				//}
				//else
				//{
					//++indexInLine;
					////target = mWordList[i].x - (indexInLine * 5);
					//target = mWordList[i].x;
				//}
				TweenLite.to(mWordList[i], 0.25, { ease:Strong.easeOut, delay:(i * 0.05),
					onComplete:OnTweenBounceWord, onCompleteParams:[mWordList[i], mWordList[i].y],
					//x:target, y:(mWordList[i].y - 50), scaleX:0.85, scaleY:1.15 } );
					y:(mWordList[i].y - 50), scaleX:0.85, scaleY:1.15 } );
				if (mPunctuationList[i])
				{
					//target += mPunctuationList[i].x - mWordList[i].x;
					TweenLite.to(mPunctuationList[i], 0.25, { ease:Strong.easeOut, delay:(i * 0.05),
					onComplete:OnTweenBouncePunctuation, onCompleteParams:[mPunctuationList[i], mPunctuationList[i].y],
					//x:(target - (mPunctuationList[i].width / 2)), y:(mPunctuationList[i].y - 50),
					y:(mPunctuationList[i].y - 50) });
					//y:(mPunctuationList[i].y - 50),
					//scaleX:0.85, scaleY:1.15 });
				}
			}
			return (0.55 + ((mWordList.length - 1) * 0.05));
		}
		
		private function OnTweenBounceWord(aWord:Sprite, aDefaultY:Number):void
		{
			TweenLite.to(aWord, 0.3, { ease:Bounce.easeOut, y:aDefaultY, scaleX:1, scaleY:1 });
		}
		
		private function OnTweenBouncePunctuation(aPunctuation:TextField, aDefaultY:Number):void
		{
			//TweenLite.to(aPunctuation, 0.3, { ease:Bounce.easeOut, y:aDefaultY, scaleX:1, scaleY:1 });
			TweenLite.to(aPunctuation, 0.3, { ease:Bounce.easeOut, y:aDefaultY });
		}
		
		private function OnPieceFreedActivityTray(aEvent:PieceTrayEvent):void
		{
			mPreviousPosition = aEvent.EventPiece.NextPiece;
			
			mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Label, MouseUtil.PositionRelativeTo(this),
				mActivityTray.BoxColor);
			mDraggedPiece.y = mActivityTray.y;
			mDraggedPiece.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
			addChild(mDraggedPiece);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			if (Asset.LetterAudioSound["_" + aEvent.EventPiece.Label])
			{
				//(new Asset.LetterAudioSound["_" + aEvent.EventPiece.Label]() as Sound).play();
				//SoundManager.PlayVO(Asset.LetterAudioSound["_" + aEvent.EventPiece.Label]);
				SoundManager.PlaySFX(Asset.LetterAudioSound["_" + aEvent.EventPiece.Label]);
			}
			
			mActivityTray.Remove(aEvent.EventPiece);
		}
		
		private function OnMouseMoveStage(aEvent:MouseEvent):void
		{
			mDraggedPiece.Position = MouseUtil.PositionRelativeTo(this);
			
			if (Math.abs(mDraggedPiece.y - mActivityTray.y) <= Math.abs(mDraggedPiece.y - mActivityTray.y))
			{
				//var position:Point = DisplayObjectUtil.GetPosition(mDraggedPiece);
				//position = position.add(DisplayObjectUtil.GetPosition(mActivityElement));
				//mActivityTray.MakePlace(mDraggedPiece, position);
				//mActivityTray.MakePlace(mDraggedPiece);
				var position:Point = null;
				//if (mWordTemplateList[mCurrentActivityIndex].ActivityToLaunch == ActivityType.WORD_CRAFTING)
				//if (mWordTemplateList[mCurrentActivityIndex].ActivityToLaunch == ActivityType.WORD_UNSCRAMBLING)
				//{
					//position = DisplayObjectUtil.GetPosition(mDraggedPiece);
					//position = position.add(DisplayObjectUtil.GetPosition(mActivityElement));
					//position = position.add(DisplayObjectUtil.GetPosition(mContent));
					//position = position.add(DisplayObjectUtil.GetPosition(mActivityTray));
					position = DisplayObjectUtil.GetPosition(mDraggedPiece);
					position = position.subtract(DisplayObjectUtil.GetPosition(mContent));
					position = position.subtract(DisplayObjectUtil.GetPosition(mActivityElement));
					position = position.subtract(DisplayObjectUtil.GetPosition(mActivityTray));
					//position = new Point();
					////position = DisplayObjectUtil.GetPosition(mDraggedPiece);
					////position = position.add(DisplayObjectUtil.GetPosition(mActivityTray));
					//position = position.add(new Point(mActivityTray.width, 0));
					////position = DisplayObjectUtil.GetPosition(mActivityTray);
					//position = position.add(DisplayObjectUtil.GetPosition(mActivityElement));
					////position = position.add(DisplayObjectUtil.GetPosition(this));
					//position = position.add(DisplayObjectUtil.GetPosition(mDraggedPiece));
				//}
				mActivityTray.MakePlace(mDraggedPiece, position);
			}
			else
			{
				mActivityTray.FreePlace();
			}
		}
		
		private function OnMouseUpStage(aEvent:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			mActivityTray.addEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedActivityTray);
			//var position:Point = DisplayObjectUtil.GetPosition(mDraggedPiece);
			//position = position.add(DisplayObjectUtil.GetPosition(mActivityElement));
			//mActivityTray.Insert(mDraggedPiece, mPreviousPosition, position);
			var position:Point = null;
			//if (mWordTemplateList[mCurrentActivityIndex].ActivityToLaunch == ActivityType.WORD_CRAFTING)
			//if (mWordTemplateList[mCurrentActivityIndex].ActivityToLaunch == ActivityType.WORD_UNSCRAMBLING)
			//{
				position = DisplayObjectUtil.GetPosition(mDraggedPiece);
				position = position.subtract(DisplayObjectUtil.GetPosition(mContent));
				position = position.subtract(DisplayObjectUtil.GetPosition(mActivityElement));
				position = position.subtract(DisplayObjectUtil.GetPosition(mActivityTray));
				//position = position.add(DisplayObjectUtil.GetPosition(this));
			//}
			mActivityTray.Insert(mDraggedPiece, mPreviousPosition, position);
			
			//UpdateAnswer();
		}
		
		private function OnPieceCapturedActivityTray(aEvent:PieceTrayEvent):void
		{
			mActivityTray.removeEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedActivityTray);
			
			removeChild(aEvent.EventPiece);
			if (aEvent.EventPiece == mDraggedPiece)
			{
				mDraggedPiece = null;
			}
		}
		
		private function OnClickScrambledWordSubmitBtn(aEvent:MouseEvent):void
		{
			var scrambledWord:ScrambledWordTemplate = mWordTemplateList[mCurrentActivityIndex] as ScrambledWordTemplate;
			if (mActivityTray.AssembleWord() == scrambledWord.Answer)
			{
				var scrambledWordFusionTimer:Timer = new Timer(mActivityTray.BounceInSequence(), 1);
				scrambledWordFusionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnScrambledWordFusionTimerComplete);
				scrambledWordFusionTimer.start();
			}
			else
			{
				mActivityTray.Fizzle();
			}
		}
		
		private function OnScrambledWordFusionTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnScrambledWordFusionTimerComplete);
			
			var scrambledWord:ScrambledWordTemplate = mWordTemplateList[mCurrentActivityIndex] as ScrambledWordTemplate;
			scrambledWord.ChunkList = new <String>[scrambledWord.Answer];
			scrambledWord.ActivityToLaunch = ActivityType.NONE;
			scrambledWord.ColorCode = ActivityType.NONE.ColorCode;
			scrambledWord.ProgressDone = true;
			
			var word:Sprite = new Sprite();
			word.x = mActivityTray.Center + mActivityElement.x;
			//word.x = mActivityElement.x;
			word.y = mActivityElement.y;
			//word.width = mActivityElement.width;
			//TweenLite.to(word, 0.5, { ease:Strong.easeOut, scaleX:1 });
			
			var i:int, endi:int;
			
			var chunkList:Vector.<CurvedBox> = new Vector.<CurvedBox>();
			var chunkOffset:Number = 0;
			var label:String;
			var labelColor:int;
			var chunk:CurvedBox;
			for (i = 0, endi = scrambledWord.ChunkList.length; i < endi; ++i)
			{
				label = scrambledWord.ChunkList[i];
				labelColor = Palette.DIALOG_CONTENT;
				switch (label)
				{
					case "_": 
						label = " ";
						labelColor = scrambledWord.ColorCode;
						break;
				}
				chunk = new CurvedBox(new Point(60, 60), scrambledWord.ColorCode, new BoxLabel(label, 45, labelColor),
					6, null, Axis.HORIZONTAL);
				chunk.ColorBorderOnly = true;
				chunkOffset += chunk.width / 2;
				chunk.x = chunkOffset;
				chunk.y = 0;
				word.addChild(chunk);
				chunkList.push(chunk);
				
				chunkOffset += (chunk.width / 2);
			}
			
			chunkOffset = -word.width / 2;
			for (i = 0, endi = chunkList.length; i < endi; ++i)
			{
				chunkList[i].x += chunkOffset;
			}
			
			mContent.addChildAt(word, mContent.getChildIndex(mActivityElement));
			mWordList[mCurrentActivityIndex] = word;
			mChunkListList[mCurrentActivityIndex] = chunkList;
			
			mSubmitBtn.removeEventListener(MouseEvent.CLICK, OnClickScrambledWordSubmitBtn);
			mSubmitBtn = null;
			
			mActivityTray.removeEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedActivityTray);
			mActivityTray.removeEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedActivityTray);
			mActivityTray.Dispose();
			mActivityTray = null;
			
			mActivityWorkArea = null;
			
			mContent.removeChild(mActivityElement);
			mActivityElement = null;
			
			var wordOffset:Number = 0;
			if (mCurrentActivityIndex)
			{
				//wordOffset = mWordList[mCurrentActivityIndex - 1].x + (mWordList[mCurrentActivityIndex - 1].width / 2) + 15;
				wordOffset = mWordList[mCurrentActivityIndex - 1].x + (mWordList[mCurrentActivityIndex - 1].width / 2);
				if (mWordTemplateList[mCurrentActivityIndex - 1].Punctuation != "'")
				{
					wordOffset += 15;
				}
			}
			
			for (i = mCurrentActivityIndex, endi = mWordList.length; i < endi; ++i)
			{
				if (i > mCurrentActivityIndex && mLineBreakList.indexOf(i) > -1)
				{
					break;
				}
				
				wordOffset += mWordList[i].width / 2;
				TweenLite.to(mWordList[i], 1, { ease:Elastic.easeOut, x:wordOffset });
				wordOffset += mWordList[i].width / 2;
				
				if (mWordTemplateList[i].Punctuation.length)
				{
					TweenLite.to(mPunctuationList[i], 1, { ease:Elastic.easeOut, x:wordOffset });
					wordOffset += mPunctuationList[i].width;
				}
				if (mWordTemplateList[i].Punctuation != "'")
				{
					wordOffset += 15;
				}
			}
			
			//UpdateContent();
			
			dispatchEvent(new ActivityBoxEvent(ActivityBoxEvent.COMPLETE_ACTIVITY));
		}
		
		private function FindAnswerVO(aAnswer:String):Class
		{
			if (Asset.WordContentSound["_" + aAnswer])
			{
				return Asset.WordContentSound["_" + aAnswer];
			}
			
			if (Asset.NewWordSound["_" + aAnswer])
			{
				return Asset.NewWordSound["_" + aAnswer];
			}
			
			if (Asset.NewChunkSound["_" + aAnswer])
			{
				return Asset.NewChunkSound["_" + aAnswer];
			}
			
			if (Asset.LetterAudioSound["_" + aAnswer])
			{
				return Asset.LetterAudioSound["_" + aAnswer];
			}
			
			return null;
		}
		
		private function OnTweenShowHighlight(aHighlight:Sprite):void
		{
			TweenLite.to(aHighlight, 1.5, {ease: Strong.easeOut, onComplete: OnTweenHideHighlight, onCompleteParams: [aHighlight], scaleX: 0.5, scaleY: 0.5, alpha: 0, rotation: 255});
		}
		
		private function OnTweenHideHighlight(aHighlight:Sprite):void
		{
			removeChild(aHighlight);
		}
		
		private function OnTweenAttentionJump(aJumpAmount:int, aWord:Sprite, aDefaultY:Number):void
		{
			TweenLite.to(aWord, 0.4, {ease: Bounce.easeOut, onComplete: OnTweenAttentionBounce, onCompleteParams: [aJumpAmount, aWord, aDefaultY], y: aDefaultY, scaleX: 1, scaleY: 1});
		}
		
		private function OnTweenAttentionBounce(aJumpAmount:int, aWord:Sprite, aDefaultY:Number):void
		{
			++aJumpAmount;
			if (aJumpAmount < 3)
			{
				TweenLite.to(aWord, 0.1, {ease: Quad.easeOut, onComplete: OnTweenAttentionJump, onCompleteParams: [aJumpAmount, aWord, aDefaultY], y: (aDefaultY - 25), scaleX: 0.9, scaleY: 1.1});
			}
			else
			{
				TweenLite.to(aWord, 0.1, {ease: Quad.easeOut, delay: 2, onComplete: OnTweenAttentionJump, onCompleteParams: [0, aWord, aDefaultY], y: (aDefaultY - 25), scaleX: 0.9, scaleY: 1.1});
			}
		}
		
		////private function OnTweenHideWordExplosion(aWordExplosion:MovieClip, aWord:Sprite, aNewChunk:CurvedBox):void
		//private function OnTweenHideWordExplosion(aWordExplosion:MovieClip, aWord:Sprite):void
		//{
		////aNewChunk.alpha = 1;
		////aWord.addChild(aNewChunk);
		//aWord.removeChild(aWordExplosion);
		//
		//aWord.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 2, 2, 4, BitmapFilterQuality.HIGH)];
		//TweenLite.to(aWord, 0.5, { glowFilter:{ alpha:1 } });
		//}
		//
		//private function OnTweenWhitenChunk(aOldChunk:CurvedBox, aWhiteBox:CurvedBox, aWord:Sprite,
		//aNewChunk:CurvedBox = null):void
		//{
		//aWord.removeChild(aOldChunk);
		//if (aNewChunk)
		//{
		////aWord.addChild(aNewChunk);
		//aNewChunk.alpha = 1;
		//}
		////aWord.addChild(aWhiteBox);
		//
		//TweenLite.to(aWhiteBox, 0.15, { ease:Strong.easeIn, onComplete:OnTweenExplodePiece,
		//onCompleteParams:[aWhiteBox, aWord], scaleX:1.2, scaleY:1.2 });
		//}
		//
		//private function OnTweenExplodePiece(aWhiteBox:CurvedBox, aWord:Sprite):void
		//{
		//var explosion:MovieClip = new Asset.PieceExplosionClip() as MovieClip;
		//explosion.x = aWhiteBox.x;
		//explosion.y = aWhiteBox.y;
		//var colorTransform:ColorTransform = new ColorTransform();
		//colorTransform.color = Palette.GREAT_BTN;
		//explosion.transform.colorTransform = colorTransform;
		//aWord.addChild(explosion);
		//
		//TweenLite.to(aWhiteBox, 0.3, { ease:Strong.easeOut, delay:0.2, onComplete:OnTweenHideExplosion,
		//onCompleteParams:[aWhiteBox, explosion, aWord], scaleX:2, scaleY:2, alpha:0 });
		//
		//(new Asset.PieceExplosionSound() as Sound).play();
		//}
		//
		//private function OnTweenHideExplosion(aWhiteBox:CurvedBox, aExplosion:MovieClip, aWord:Sprite):void
		//{
		//aWord.removeChild(aWhiteBox);
		//aWord.removeChild(aExplosion);
		//}
		
		//private function OnTweenGlowStrong(aWord:Sprite):void
		//{
		//TweenLite.to(aWord, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowWeak, onCompleteParams:[aWord],
		//glowFilter:{ alpha:0.25 } });
		//}
		
		//private function OnTweenGlowWeak(aWord:Sprite):void
		//{
		//TweenLite.to(aWord, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowStrong, onCompleteParams:[aWord],
		//glowFilter:{ alpha:0.75 } });
		//}
		
		private function OnClickWordAudio(aEvent:MouseEvent):void
		{
			var index:int = mWordList.indexOf(aEvent.currentTarget as Sprite);
			var vo:String = mWordTemplateList[index].VO;
			if (vo)
			{
				//(new Asset.WordContentSound["_" + vo]() as Sound).play();
				//SoundManager.PlayVO(Asset.WordContentSound["_" + vo]);
				SoundManager.PlaySFX(Asset.WordContentSound["_" + vo]);
			}
		}
		
		private function OnClickWord(aEvent:MouseEvent):void
		{
			var index:int = mWordList.indexOf(aEvent.currentTarget as Sprite);
			//dispatchEvent(new ActivityBoxEvent(ActivityBoxEvent.LAUNCH_ACTIVITY, mWordTemplateList[index].ActivityToLaunch));
			
			var activityToLaunch:ActivityTemplate;
			switch (mWordTemplateList[index].ActivityToLaunch)
			{
				case ActivityType.WORD_UNSCRAMBLING:
					var scrambledWord:ScrambledWordTemplate = mWordTemplateList[index] as ScrambledWordTemplate;
					activityToLaunch = new WordUnscramblingTemplate(mQuestStep.StepLevel, scrambledWord,
						//FindAnswerVO(scrambledWord.Answer), mWordTemplateList, mLineBreakList, mPointDirection);
						mSentenceVO, mWordTemplateList, mLineBreakList, mPointDirection);
					break;
				case ActivityType.WORD_CRAFTING:
					var emptyWord:EmptyWordTemplate = mWordTemplateList[index] as EmptyWordTemplate;
					activityToLaunch = new WordCraftingTemplate(mQuestStep.StepLevel, emptyWord,
						//FindAnswerVO(emptyWord.Answer), mWordTemplateList, mLineBreakList, mPointDirection);
						mSentenceVO, mWordTemplateList, mLineBreakList, mPointDirection);
					break;
				case ActivityType.SENTENCE_DECRYPTING:
					activityToLaunch = new SentenceDecryptingTemplate(mQuestStep.StepLevel, mSentenceVO, mWordTemplateList,
						mLineBreakList, mPointDirection);
					break;
				//case ActivityType.SENTENCE_UNSCRAMBLING:
					//var wordList:Vector.<String> = new Vector.<String>();
					//for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
					//{
						//wordList.push(mWordTemplateList[i].ChunkList.join("");
					//}
					//var misplacedWord:MisplacedWordTemplate = mWordTemplateList[index] as MisplacedWordTemplate;
					//activityToLaunch = new SentenceUnscramblingTemplate(mQuestStep.StepLevel, wordList, misplacedWord.Answer,
						//misplacedWord.ChunkList.join(""), FindAnswerVO(misplacedWord.Answer), mWordTemplateList, mLineBreakList,
						//mPointDirection);
					//break;
				default: 
					//throw new Error("Word " + mWordTemplateList[index].ChunkList.join("") + " does not have an activity type.");
					return;
			}
			
			dispatchEvent(new ActivityBoxEvent(ActivityBoxEvent.LAUNCH_ACTIVITY, activityToLaunch));
		}
		
		private function OnClickMegaphoneBtn(aEvent:MouseEvent):void
		{
			//(new mSentenceVO() as Sound).play();
			SoundManager.PlayVO(mSentenceVO);
		}
	
		//private function OnClickHintBtn(aEvent:MouseEvent):void
		//{
		//(new mHint() as Sound).play();
		//}
		
		//private function OnClick(aEvent:MouseEvent):void
		//{
		//dispatchEvent(new ActivityBoxEvent(ActivityBoxEvent.LAUNCH_ACTIVITY));
		//}
	}
}