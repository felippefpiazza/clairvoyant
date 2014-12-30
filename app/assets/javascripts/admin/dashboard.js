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
		    }, 3000000)
		  };

		$scope.toogleClairvoyantDetails = function(clairvoyant_id){
			if ($scope.clairvoyant_details) {
				$scope.clairvoyant_details=false;
			} else {
				$scope.getDeviceData(clairvoyant_id)
				$scope.clairvoyant_details=true;
			}
		}

		$scope.clairvoyants = []
		$scope.clairvoyants_devices = {"clairvoyant": {}, "devices": []}
		$scope.search_client_id = "";
		$scope.search_serial = "";
		$scope.getClairvoyantData();
		$scope.intervalFunction();
		

	}]);


