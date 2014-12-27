angular.module('RefreshDashboard', [])
	.controller('DashboardController', ['$scope', '$http', function($scope, $http) { $http.get("http://172.16.49.100:3000/api/all_clairvoyants.json")
    .success(function(response) {$scope.clairvoyants = response;});
		
		$scope.addClairvoyant = function() {
			$scope.clairvoyants.push({text:$scope.ClairvoyantName, serial:$scope.ClairvoyantSerial, parameters: {}});
			$scope.ClairvoyantName = '';
			$scope.ClairvoyantSerial = '';
		};
		
		
		
		}]);
	
	
function getClairvoyants($scope,$http) {
    $http.get("http://172.16.49.100:3000/api/all_clairvoyants.json")
    .success(function(response) {$scope.clairvoyants = response;});
}

getClairvoyants	
/*	
		$http.get("http://172.16.49.100:3000/api/all_clairvoyants.json").success(function(data, status, headers, config) {
		      $scope.clairvoyants = data;
		    });	

$scope.clairvoyants = [
	{equipment:'Clairvoyant #1', serial_hexa:'0x00000001', parameters: [['param1','1'],['param2','2']]},
	{equipment:'Clairvoyant #2', serial_hexa:'0x00000002', parameters: [['other1','6'],['other2','7']]},
	{equipment:'Clairvoyant #3', serial_hexa:'0x00000003', parameters: [['other1','6'],['other2','7']]},
	{equipment:'Clairvoyant #4', serial_hexa:'0x00000004', parameters: [['other1','6'],['other2','7']]},
	{equipment:'Clairvoyant #5', serial_hexa:'0x00000005', parameters: [['other1','6'],['other2','7']]},
	{equipment:'Clairvoyant #6', serial_hexa:'0x00000006', parameters: [['other1','6'],['other2','7']]},		
	{equipment:'Clairvoyant #7', serial_hexa:'0x00000007', parameters: [['other1','6'],['other2','7']]}
	];
*/