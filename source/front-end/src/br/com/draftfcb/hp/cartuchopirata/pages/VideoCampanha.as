package br.com.draftfcb.hp.cartuchopirata.pages {
	
	import caurina.transitions.Tweener;
	
	import com.avmvc.avMvc;
	import com.avmvc.events.PageEvent;
	import com.avmvc.interfaces.IPage;
	import com.avmvc.loader.avMvcLoaderEvent;
	import com.avmvc.view.Page;
	import com.debug.arthropod.Debug;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;

	/**
	 * <b>Author:</b> Allan Avelar<br />
	 */
	
	public class VideoCampanha extends Page implements IPage {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var blockBG:bgColor;
		private var blockBtns:Boolean = true;
		private var videoCampanha:MovieClip;
		private var apiloader:Loader;
		private var player:Object;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function VideoCampanha() {
			alpha = 0;
			visible = false;
			addEventListener(PageEvent.INITIALIZED, initialized, false, 0, true);
			addEventListener(PageEvent.CONTENT_PARSED, contentParsed, false, 0, true);
			addEventListener(PageEvent.CONTENT_COMPLETE, contentComplete, false, 0, true);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function initialized(e:PageEvent = null):void {
			removeEventListener(PageEvent.INITIALIZED, initialized, false);
			// initialization complete, build page elements here
			loadCampanha();
		}
		
		private function contentParsed(e:PageEvent):void {
			removeEventListener(PageEvent.CONTENT_PARSED, contentParsed, false);
			// assets parsed and ready (except the assets that need to be loaded), retrieve the assets using: getAssetByID(myAssetID)
		}
		
		private function contentComplete(e:PageEvent):void {
			removeEventListener(PageEvent.CONTENT_COMPLETE, contentComplete, false);
			// assets fully parsed and loaded, retrieve the assets using: getAssetByID(myAssetID)
		}
		
		private function dispose():void {
			// remove and destroy everything in the page
			try {
				removeEventListener(PageEvent.INITIALIZED, initialized, false);
				removeEventListener(PageEvent.CONTENT_PARSED, contentParsed, false);
				removeEventListener(PageEvent.CONTENT_COMPLETE, contentComplete, false);
				
				avMvc.getInstance().loader.removeEventListener(avMvcLoaderEvent.COMPLETE, itensComplete);
				apiloader.contentLoaderInfo.removeEventListener(Event.INIT, onLoadYoutubeApi);
				
				apiloader.content.removeEventListener("onReady", onPlayerReady);
				apiloader.content.removeEventListener("onError", onPlayerError);
				apiloader.content.removeEventListener("onStateChange", onPlayerStateChange);
				apiloader.content.removeEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
			} catch(e:Error) {
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function transitionIn():void {
			// start of the transition to show the page, then call super.transitionIn
			Tweener.addTween(this, {time:0, _autoAlpha:1, onComplete:super.transitionIn});
		}

		override public function transitionInComplete():void {
			// end of the transition to show the page, then call super.transitionInComplete
			super.transitionInComplete();
		}
		
		override public function transitionOut():void {
			// start of the transition to hide the page, then call super.transitionOut
			Tweener.addTween(videoCampanha, { time:1.3, y:0, onComplete:removeVideoCampanha});
			Tweener.addTween(blockBG, {time:1, alpha:0, onComplete:removeBlockBG});
			player.stopVideo();
		}
		
		override public function transitionOutComplete():void {
			// end of the transition to hide the page, then call super.transitionOutComplete
			dispose();
			super.transitionOutComplete();
		}
		
		private function loadCampanha():void {
			try{
				Debug.log ( this + ">>loadCampanha()" );
				avMvc.getInstance().loader.addEventListener(avMvcLoaderEvent.COMPLETE, itensComplete);
				avMvc.getInstance().loader.add("internas/videocampanha.swf");
				avMvc.getInstance().loader.start();
			} catch(e:Error) {
				Debug.log("itemCompleteError: " + e);
			}
		}
		
		private function loadYoutubeApi():void {
			try{
				Debug.log ( this + ">>loadYoutubeApi()" );
				
				apiloader = new Loader();
				apiloader.contentLoaderInfo.addEventListener(Event.INIT, onLoadYoutubeApi);
				apiloader.load(new URLRequest("http://www.youtube.com/apiplayer?version=3"));
				
			} catch(e:Error) {
				Debug.log("itemCompleteError: " + e);
			}
		}
		
		private function itensComplete(event:avMvcLoaderEvent):void {
			try{
				Debug.log("itensComplete: " + event.item.url);
				if(event.item.url == "internas/videocampanha.swf") {
					onLoadCampanha(event);
				}
			} catch(e:Error) {
				Debug.log("itemCompleteError: " + e);
			}
		}
		
		private function onLoadCampanha(event:avMvcLoaderEvent):void {
			try {
				Debug.log(this + ">>onLoadCampanha()");
				
				blockBG = new bgColor();
				blockBG.x = blockBG.y = blockBG.alpha = 0;
				blockBG.width = avMvc.getInstance().container.stage.stageWidth;
				blockBG.height = avMvc.getInstance().container.stage.stageHeight;
				
				addChild(blockBG);
				
				Tweener.addTween(blockBG, {time:2.5, alpha:0.5});

				videoCampanha = MovieClip(event.item.file).videocampanha;
				videoCampanha.y = 680; videoCampanha.play();
				addChild(videoCampanha);
				
				Debug.log(this + ">>campanha.atual: " + avMvc.getInstance().config.params.campanha.atual);
				videoCampanha.mcTv.mcAreaVideo.gotoAndStop(Number(avMvc.getInstance().config.params.campanha.atual));
				
				loadYoutubeApi();
				
				videoCampanha.btNext.addEventListener(MouseEvent.CLICK, onClickNext);
				videoCampanha.btPrevious.addEventListener(MouseEvent.CLICK, onClickBack);
				
				videoCampanha.mcBtFechar.addEventListener(MouseEvent.CLICK, closeVideo);

				try {
					ExternalInterface.call("scrollToTop");
				} catch(e:Error) {
					
				}
				
			} catch(e:Error) {
				Debug.log("itemCompleteError: " + e);
			}
		}
		
		private function onLoadYoutubeApi(event:Event):void {
			try {
				Debug.log(this + ">>onLoadYoutubeApi()");
				
				videoCampanha.vid.addChild(apiloader);
				
				apiloader.content.addEventListener("onReady", onPlayerReady);
				apiloader.content.addEventListener("onError", onPlayerError);
				apiloader.content.addEventListener("onStateChange", onPlayerStateChange);
				apiloader.content.addEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
				
			} catch(e:Error) {
				Debug.log("onLoadYoutubeApiError: " + e);
			}
		}
		private function onPlayerReady(event:Event):void {
			Debug.log(this + ">>player ready:" + Object(event).data);
			Debug.log(this + ">>code: " + avMvc.getInstance().config.params.campanha.codes[avMvc.getInstance().config.params.campanha.atual - 1]);
			player = apiloader.content; player.setSize(462, 325);
			player.cueVideoById(avMvc.getInstance().config.params.campanha.codes[avMvc.getInstance().config.params.campanha.atual - 1]);
			blockBtns = false;
		}
		private function onPlayerError(event:Event):void {
			Debug.log(this + ">>player error:" + Object(event).data);
		}
		private function onPlayerStateChange(event:Event):void {
			Debug.log(this + ">>player state:" + Object(event).data);
		}
		private function onVideoPlaybackQualityChange(event:Event):void {
			Debug.log(this + ">>video quality:" + Object(event).data);
		}
		
		private function closeVideo(event:MouseEvent):void {
			new PageEvent(PageEvent.SHOW, "Home").dispatch();
		}
		private function removeBlockBG():void {
			if(blockBG != null && contains(blockBG)) {
				removeChild(blockBG);
			}
		}
		private function removeVideoCampanha():void {
			removeChild(videoCampanha);
			super.transitionOut();
		}
		
		private function onClickNext(e:MouseEvent):void {
			if (!blockBtns) {
				if (videoCampanha.mcTv.mcAreaVideo.currentFrame == videoCampanha.mcTv.mcAreaVideo.totalFrames) {
					videoCampanha.mcTv.mcAreaVideo.gotoAndStop(1);
				} else {
					videoCampanha.mcTv.mcAreaVideo.gotoAndStop(videoCampanha.mcTv.mcAreaVideo.currentFrame + 1);
				}
				avMvc.getInstance().config.params.campanha.atual = videoCampanha.mcTv.mcAreaVideo.currentFrame;
				player.stopVideo(); loadYoutubeApi(); blockBtns = true;
			}
		}
		
		private function onClickBack(e:MouseEvent):void {
			if (!blockBtns) {
				if (videoCampanha.mcTv.mcAreaVideo.currentFrame == 1) {
					videoCampanha.mcTv.mcAreaVideo.gotoAndStop(videoCampanha.mcTv.mcAreaVideo.totalFrames);
				} else {
					videoCampanha.mcTv.mcAreaVideo.gotoAndStop(videoCampanha.mcTv.mcAreaVideo.currentFrame - 1);
				}
				avMvc.getInstance().config.params.campanha.atual = videoCampanha.mcTv.mcAreaVideo.currentFrame;
				player.stopVideo(); loadYoutubeApi(); blockBtns = true;
			}
		}
	}
}
