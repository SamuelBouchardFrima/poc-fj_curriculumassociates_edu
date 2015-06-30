package com.frimastudio.fj_curriculumassociates_edu.activity
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxIcon;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Geometry;
	import com.frimastudio.fj_curriculumassociates_edu.util.MathUtil;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
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
	
	public class ActivityBox extends Box
	{
		private var mWordTemplateList:Vector.<WordTemplate>;
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
		
		public function get WordTemplateList():Vector.<WordTemplate>	{ return mWordTemplateList; }
		public function set WordTemplateList(aValue:Vector.<WordTemplate>):void
		{
			mWordTemplateList = aValue;
			//UpdateContent();
		}
		
		public function get CurrentActivityCenter():Point
		{
			var thisPosition:Point = DisplayObjectUtil.GetPosition(this);
			var contentPosition:Point = DisplayObjectUtil.GetPosition(mContent);
			
			for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
			{
				if (mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE)
				{
					return thisPosition.add(contentPosition).add(DisplayObjectUtil.GetPosition(mWordList[i]));
				}
			}
			
			throw new Error("Could not find a word with a corresponding activity. Use SentenceCenter instead.");
			return new Point();
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
			
			return thisPosition.add(contentPosition).add(Geometry.RectangleCenter(sentenceBounds));
		}
		
		public function ActivityBox(aWordTemplateList:Vector.<WordTemplate>, aLineBreakList:Vector.<int>, aSentenceVO:Class,
			aPhylacteryArrow:Direction, aGhostContent:Boolean = false, aLaunchingActivity:Boolean = false, aHint:Class = null)
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
			
			mContent.x = -382;
			
			if (mLaunchingActivity)
			{
				mWholeBoxClickable = true;
				for (var i:int = 0, endi:int = mWordTemplateList.length; i < endi; ++i)
				{
					if (mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE)
					{
						mWholeBoxClickable = false;
						break;
					}
				}
			}
			
			if (mWholeBoxClickable)
			{
				addEventListener(MouseEvent.CLICK, OnClick);
				
				mMegaphoneBtn = new CurvedBox(new Point(80, 80), 0x999999, new BoxIcon(Asset.IconEarBitmap, Palette.BTN_CONTENT));
				mMegaphoneBtn.x = -442;
				mMegaphoneBtn.y = 0;
				addChild(mMegaphoneBtn);
			}
			else
			{
				mMegaphoneBtn = new CurvedBox(new Point(80, 80), Palette.GREAT_BTN,
					new BoxIcon(Asset.IconEarBitmap, Palette.BTN_CONTENT));
				mMegaphoneBtn.x = -442;
				mMegaphoneBtn.y = 0;
				mMegaphoneBtn.addEventListener(MouseEvent.CLICK, OnClickMegaphoneBtn);
				addChild(mMegaphoneBtn);
			}
			
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
			
			removeEventListener(MouseEvent.CLICK, OnClick);
			mMegaphoneBtn.removeEventListener(MouseEvent.CLICK, OnClickMegaphoneBtn);
			//mHintBtn.removeEventListener(MouseEvent.CLICK, OnClickHintBtn);
		}
		
		public function UpdateCurrentActivityContent(aChunkList:Vector.<String>, aGhostContent:Boolean = false,
			aOneWord:Boolean = true):void
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
							mWordTemplateList[0].ChunkList[0] = mWordTemplateList[0].ChunkList[0].charAt(0).toUpperCase() +
								mWordTemplateList[0].ChunkList[0].substring(1, mWordTemplateList[0].ChunkList[0].length);
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
			mPunctuationList = { };
			
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
					chunk = new CurvedBox(new Point(60, 60), mWordTemplateList[i].ColorCode, new BoxLabel(label, 45, labelColor),
						3, null, Axis.HORIZONTAL);
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
				
				word.alpha = (mGhostContent && mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE ? 0.5 : 1);
				
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
								if (mWordTemplateList[i].ProgressDone)
								{
									word.filters = [new GlowFilter(Palette.GREAT_BTN, 1, 2, 2, 4, BitmapFilterQuality.HIGH)];
								}
								
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
					punctuation.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 45, Palette.DIALOG_CONTENT,
						null, null, null, null, null, TextFormatAlign.CENTER));
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
				TweenLite.to(wordTweenList[i], 0.1, { ease:Quad.easeOut, onComplete:OnTweenAttentionJump,
					onCompleteParams:[0, wordTweenList[i], wordTweenList[i].y], y:(wordTweenList[i].y - 25),
					scaleX:0.9, scaleY:1.1 });
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
				
				if (chunkList.length == mWordTemplateList[i].ChunkList.length)
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
								new BoxLabel(label, 45, labelColor), 3, null, Axis.HORIZONTAL);
							chunk.ColorBorderOnly = true;
							chunkOffset += chunk.width / 2;
							chunk.x = chunkList[j].x;
							chunkTargetList.push(chunkOffset);
							chunk.y = 0;
							word.addChild(chunk);
							
							if (aPlayExplosion)
							{
								highlight = new Sprite();
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
								
								TweenLite.to(highlight, 0.2, { ease:Strong.easeIn, onComplete:OnTweenShowHighlight,
									onCompleteParams:[highlight], scaleX:1, scaleY:1, alpha:1, rotation:30 });
								
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
								word.removeChild(chunkList[j]);
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
						new BoxLabel(mWordTemplateList[i].ChunkList[0], 45, Palette.DIALOG_CONTENT), 3, null, Axis.HORIZONTAL);
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
						
						TweenLite.to(highlight, 0.2, { ease:Strong.easeIn, onComplete:OnTweenShowHighlight,
							onCompleteParams:[highlight], scaleX:1, scaleY:1, alpha:1, rotation:30 });
						
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
						
						word.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 2, 2, 4, BitmapFilterQuality.HIGH)];
						TweenLite.to(word, 0.5, { glowFilter:{ alpha:1 } });
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
					TweenLite.to(chunkList[j], 1, { ease:Elastic.easeOut, x:(chunkTargetList[j] + chunkOffset) });
				}
				
				if (mLineBreakList.indexOf(i) > -1)
				{
					wordOffset = 0;
				}
				
				//wordOffset += word.width / 2;
				wordOffset += wordWidth / 2;
				TweenLite.to(word, 1, { ease:Elastic.easeOut, x:wordOffset });
				
				word.alpha = (mGhostContent && mWordTemplateList[i].ActivityToLaunch != ActivityType.NONE ? 0.5 : 1);
				
				word.graphics.beginFill(0x000000, 0);
				word.graphics.drawRect(-word.width / 2, -word.height / 2, word.width, word.height);
				word.graphics.endFill();
				
				//wordOffset += word.width / 2;
				wordOffset += wordWidth / 2;
				
				if (mWordTemplateList[i].Punctuation.length)
				{
					TweenLite.to(mPunctuationList[i], 1, { ease:Elastic.easeOut, x:wordOffset } );
					wordOffset += mPunctuationList[i].width;
				}
				if (mWordTemplateList[i].Punctuation != "'")
				{
					//wordOffset += 10;
					wordOffset += 15;
				}
			}
		}
		
		private function OnTweenShowHighlight(aHighlight:Sprite):void
		{
			TweenLite.to(aHighlight, 1.5, { ease:Strong.easeOut, onComplete:OnTweenHideHighlight,
				onCompleteParams:[aHighlight], scaleX:0.5, scaleY:0.5, alpha:0, rotation:255 });
		}
		
		private function OnTweenHideHighlight(aHighlight:Sprite):void
		{
			removeChild(aHighlight);
		}
		
		private function OnTweenAttentionJump(aJumpAmount:int, aWord:Sprite, aDefaultY:Number):void
		{
			TweenLite.to(aWord, 0.4, { ease:Bounce.easeOut, onComplete:OnTweenAttentionBounce,
				onCompleteParams:[aJumpAmount, aWord, aDefaultY], y:aDefaultY, scaleX:1, scaleY:1 });
		}
		
		private function OnTweenAttentionBounce(aJumpAmount:int, aWord:Sprite, aDefaultY:Number):void
		{
			++aJumpAmount;
			if (aJumpAmount < 3)
			{
				TweenLite.to(aWord, 0.1, { ease:Quad.easeOut, onComplete:OnTweenAttentionJump,
					onCompleteParams:[aJumpAmount, aWord, aDefaultY], y:(aDefaultY - 25), scaleX:0.9, scaleY:1.1 });
			}
			else
			{
				TweenLite.to(aWord, 0.1, { ease:Quad.easeOut, delay:2, onComplete:OnTweenAttentionJump,
					onCompleteParams:[0, aWord, aDefaultY], y:(aDefaultY - 25), scaleX:0.9, scaleY:1.1 });
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
				(new Asset.WordContentSound["_" + vo]() as Sound).play();
			}
		}
		
		private function OnClickWord(aEvent:MouseEvent):void
		{
			var index:int = mWordList.indexOf(aEvent.currentTarget as Sprite);
			dispatchEvent(new ActivityBoxEvent(ActivityBoxEvent.LAUNCH_ACTIVITY, mWordTemplateList[index].ActivityToLaunch));
		}
		
		private function OnClickMegaphoneBtn(aEvent:MouseEvent):void
		{
			(new mSentenceVO() as Sound).play();
		}
		
		//private function OnClickHintBtn(aEvent:MouseEvent):void
		//{
			//(new mHint() as Sound).play();
		//}
		
		private function OnClick(aEvent:MouseEvent):void
		{
			dispatchEvent(new ActivityBoxEvent(ActivityBoxEvent.LAUNCH_ACTIVITY));
		}
	}
}