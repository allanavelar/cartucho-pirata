package br.com.draftfcb.hp.cartuchopirata.pages.controls
{	
	import caurina.transitions.Tweener;
	
	import com.avmvc.avMvc;
	import com.avmvc.events.PageEvent;
	import com.debug.arthropod.Debug;
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class PeelControl
	{
		protected static var _instance:PeelControl;
		
		private var peel:MovieClip;
		private var frameSetup:Number = 2;
		private var constGaId:String = "UA-10714720-2";
		private var apiloader:Loader;
		private var player:Object;
		private var oGA:AnalyticsTracker;
		
		public static function to(mc:MovieClip):void { return getInstance().to(mc); }
		public function to(mc:MovieClip):void {
			peel = mc;
			addClickPeel();
		}
		
		public static function autoOpen():void { return getInstance().autoOpen(); }
		public function autoOpen():void {
			Tweener.addTween(peel, {_frame:peel.totalFrames, delay:2, time:2, onComplete:function():void {
				Tweener.addTween(peel, {_frame:1, delay:5, time:2, onComplete:addClickPeel});
			}});
		}
		
		private function execPeel(e:Event):void {
			Tweener.addTween(peel, {_frame:peel.totalFrames, time:2, onComplete:addVideoPeel});
			
			peel.btClickPeel.removeEventListener(MouseEvent.CLICK, execPeel);
			peel.btClickPeel.removeEventListener(MouseEvent.ROLL_OUT, outPeel);
			peel.btClickPeel.removeEventListener(MouseEvent.ROLL_OVER, overPeel);
			
			TrackEventGA("Home","AbrePeel");
		}
		
		private function overPeel(e:MouseEvent):void {
			Tweener.addTween(peel, {_frame:7, time:0.3});
		}
		private function outPeel(e:MouseEvent):void {
			Tweener.addTween(peel, {_frame:1, time:0.3});
		}
		
		private function addVideoPeel(e:Event = null):void {
			Debug.log(this + ">>addVideoPeel()");
			try {
				/*peel.mcCartucho.btCliqueCompre.addEventListener(MouseEvent.CLICK, clickCompre);
				peel.mcCartucho.btCliqueCompre.mouseChildren = false;
				peel.mcCartucho.btCliqueCompre.buttonMode = true;*/
				
				peel.mcCartucho.mcFilme.mcPlay.addEventListener(MouseEvent.CLICK, trackPlayPeel);
				peel.mcCartucho.mcFilme.mcPlay.addEventListener(MouseEvent.MOUSE_OVER, overPlayPeel);
				peel.mcCartucho.mcFilme.mcPlay.addEventListener(MouseEvent.MOUSE_OUT, outPlayPeel);
				peel.mcCartucho.mcFilme.mcPlay.mouseChildren = true;
				peel.mcCartucho.mcFilme.mcPlay.buttonMode = true;
				
				peel.mcCartucho.btnCliqueAqui.addEventListener(MouseEvent.CLICK, peelCliqueAqui);
				peel.mcCartucho.btnFechar.addEventListener(MouseEvent.CLICK, closePeel);
				peel.mcCartucho.btnLogoHP.addEventListener(MouseEvent.CLICK, openHPSite);
				
				loadYoutubeApi();
			}
			catch(e:Error) {
			}
		}
		
		private function overPlayPeel(e:MouseEvent):void {
			if(peel.mcCartucho.mcFilme.mcPlay.currentFrame == 2) {
				peel.mcCartucho.mcFilme.mcPlay.alpha = .3;
			}
		}
		private function outPlayPeel(e:MouseEvent):void {
			if(peel.mcCartucho.mcFilme.mcPlay.currentFrame == 2) {
				peel.mcCartucho.mcFilme.mcPlay.alpha = 0;
			}
		}
		private function trackPlayPeel(e:MouseEvent):void {
			TrackEventGA("Peel", "PlayVideoPeel");
			if(player) {
				if(e.currentTarget.currentFrame == 1) {
					player.playVideo();
					e.currentTarget.alpha = .3;
					e.currentTarget.gotoAndStop(2);
				} else {
					player.pauseVideo();
					e.currentTarget.alpha = 1;
					e.currentTarget.gotoAndStop(1);
				}
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
		private function onLoadYoutubeApi(event:Event):void {
			try {
				Debug.log(this + ">>onLoadYoutubeApi()");
				
				peel.mcCartucho.mcFilme.vid.addChild(apiloader);
				
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
			player = apiloader.content; player.setSize(348, 198);
			player.cueVideoById(avMvc.getInstance().config.params.campanha.peel);
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
		
		private function peelCliqueAqui(e:Event):void {
			navigateToURL(new URLRequest(avMvc.getInstance().config.params.peel.urlClique));
		}
		private function clickCompre(e:Event):void {
			ExternalInterface.call("openBrowser", avMvc.getInstance().config.params.peel.urlCompre);
		}
		private function openHPSite(e:Event):void {
			navigateToURL(new URLRequest(avMvc.getInstance().config.params.hp.url),"_blank");
		}
		
		private function closePeel(event:MouseEvent):void {
			try {
				Tweener.addTween(peel, {_frame:1, time:2, onComplete:addClickPeel});
				peel.mcCartucho.btnFechar.removeEventListener(MouseEvent.CLICK, closePeel);
				player.stopVideo(); TrackEventGA("Home","FechaPeel");
			} catch(e:Error) {
				Debug.log("onLoadYoutubeApiError: " + e);
			}
		}
		
		private function addClickPeel(event:Event=null):void {
			try {
				peel.btClickPeel.addEventListener(MouseEvent.CLICK, execPeel);
				peel.btClickPeel.addEventListener(MouseEvent.ROLL_OUT, outPeel);
				peel.btClickPeel.addEventListener(MouseEvent.ROLL_OVER, overPeel);
				peel.btClickPeel.mouseChildren = false;
				peel.btClickPeel.buttonMode = true;
			} catch(e:Error) {}
		}
		
		public function TrackEventGA(section:String, event:String):void {
			if (oGA==null) {
				oGA = new GATracker(peel.stage, constGaId, "AS3", false );
			}
			if (oGA!=null) {
				oGA.trackEvent(section,event);
			}
		}
		
		protected static function getInstance():PeelControl {
			if (_instance == null) { _instance= new PeelControl(); }
			return _instance;
		}
	}
}