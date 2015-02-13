angular.module('RefreshDashboard', ['ngAnimate'])
	.controller('DashboardController', ['$scope', '$http', '$timeout', function($scope, $http, $timeout) {
		
		$scope.getClairvoyantData = function() {
			$http.post("/api/all_clairvoyants.json", {serial: $scope.search_serial, client_id:$scope.search_client_id })
    			.success(function(response) {
					$scope.clairvoyants = response;
				});
		};
		
		$scope.getDeviceData = function(clairvoyant_id) {
			$http.post("/api/clairvoyant_devices.json", {clairvoyant_id:clairvoyant_id })
    			.success(function(response) {
					$scope.clairvoyant_devices = response;
				});
		};		

		$scope.getControllerData = function(controller_id) {
			$http.post("/api/controller_data.json", {device_id: $scope.getcontroller_controller_id})
    			.success(function(response) {
					$scope.controller_data_store = response;
					$scope.toogleControllerDataMenu();
				});
		};

		$scope.intervalgetControllerData = function(){
			$scope.getControllerData();
			if(!$scope.pull_controller_data) {
				$timeout.cancel(controller_data_pulling_timeout);
			}
		    var controller_data_pulling_timeout = $timeout(function() {
		      $scope.intervalgetControllerData();
		    }, 20000);
		  };	



		$scope.ClearControllerData = function(){
			$scope.controller_data_infos = null;
			$scope.controller_data_params = null;
			$scope.controller_data_faults = null;
			$scope.controller_data_faultshistory = null;
			$scope.info_header = false
			$scope.param_header = false
			$scope.fault_header = false
			$scope.faulthistory_header = false	
		};
		
		$scope.toogleControllerDataMenu = function(menu) {
			if (!(menu  === undefined || menu === null || menu === "")) {
				$scope.controller_selected_menu = menu;
			};
			
			$scope.ClearControllerData();
			switch ($scope.controller_selected_menu) {
			    case "infos":
					$scope.controller_selected_menu = "infos";
					$scope.controller_data_infos = $scope.controller_data_store.d_infos;
					$scope.info_header = true
			        break;
			    case "params":
					$scope.controller_selected_menu = "params";
					$scope.controller_data_params = $scope.controller_data_store.d_params;
					$scope.param_header = true					
			        break;
			    case "faults":
					$scope.controller_selected_menu = "faults";
					$scope.controller_data_faults = $scope.controller_data_store.d_faults;
					$scope.fault_header = true				
			        break;
			    case "faultshistory":
					$scope.controller_selected_menu = "faultshistory";
					$scope.controller_data_faultshistory = $scope.controller_data_store.d_faultshistory;
					$scope.faulthistory_header = true					
			        break;			
			    default:
			        $scope.controller_data_infos = $scope.controller_data_store.d_infos;
			};
		};
		
		
		
		
		$scope.addClairvoyant = function() {
			$scope.clairvoyants.push({equipment:$scope.ClairvoyantName, serial_hex:$scope.ClairvoyantSerial, parameters: {}});
			$scope.ClairvoyantName = '';
			$scope.ClairvoyantSerial = '';
		};
		
		$scope.searchClairvoyant = function() {
			$scope.search_client_id = $scope.SearchClient;
			$scope.search_serial = $scope.SearchSerial;
			$scope.getClairvoyantData();
		};

		$scope.intervalFunction = function(){
		    $timeout(function() {
		      $scope.getClairvoyantData();
		      $scope.intervalFunction();
		    }, 20000)
		  };

		$scope.toogleClairvoyantDetails = function(clairvoyant_id){
			if ($scope.clairvoyant_details) {
				$scope.controller_details=false;
				$scope.clairvoyant_details=false;
			} else {
				$scope.getDeviceData(clairvoyant_id)
				$scope.clairvoyant_details=true;
			}
		}

		$scope.openControllerDetails = function(clairvoyant_id,controller_id){
				$scope.getcontroller_controller_id = controller_id;
				$scope.getDeviceData(clairvoyant_id);
				$scope.getControllerData();
				$scope.controller_details=true;
				if (!$scope.pull_controller_details) {
					$scope.pull_controller_data=true;
					$scope.intervalgetControllerData();
				} 
		}

		$scope.closeControllerDetails = function() {
			$scope.controller_details=false;
			$scope.pull_controller_data=false;
			
		}

		$scope.pull_controller_data = false;
		$scope.getcontroller_controller_id = 0;
		$scope.clairvoyants = [];
		$scope.clairvoyants_devices = {"clairvoyant": {}, "devices": []};
		$scope.search_client_id = "";
		$scope.search_serial = "";
		$scope.getClairvoyantData();
		$scope.intervalFunction();
		$scope.controller_selected_menu = "infos";

	}]);


