//-- copyright
// OpenProject is a project management system.
// Copyright (C) 2012-2015 the OpenProject Foundation (OPF)
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License version 3.
//
// OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
// Copyright (C) 2006-2013 Jean-Philippe Lang
// Copyright (C) 2010-2013 the ChiliProject Team
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//
// See doc/COPYRIGHT.rdoc for more details.
//++

module.exports = function($scope, $filter, columnsModal, QueryService, WorkPackageService, WorkPackagesTableService, $rootScope) {

  this.name    = 'Columns';
  this.closeMe = columnsModal.deactivate;

  $scope.vm = {};
  $scope.vm.availableColumns = [];
  $scope.vm.ready = false;

  // Selected Columns
  var selectedColumns = _.cloneDeep(QueryService.getSelectedColumns());
  $scope.vm.selectedColumns = selectedColumns;

  // Available selectable Columns
  QueryService.loadAvailableColumns()
    .then(function(availableColumns){
      console.log('AVA: ' + availableColumns);
      $scope.vm.availableColumns = availableColumns;
      $scope.vm.ready = true;
    });

  $scope.updateSelectedColumns = function(){
    // Note: Can't directly manipulate selected columns because select2 returns a new array when you change the values:(
    //QueryService.setSelectedColumns(getColumnIdentifiersFromSelection($scope.selectedColumnsData));

    // Augment work packages with new columns data
    var addedColumns        = getNewlyAddedColumns(),
        currentWorkPackages = WorkPackagesTableService.getRowsData(),
        groupBy             = WorkPackagesTableService.getGroupBy();

    if(groupBy.length === 0) groupBy = undefined; // don't pass an empty string as groupBy

    if(addedColumns.length) {
      $rootScope.refreshWorkPackages = WorkPackageService.augmentWorkPackagesWithColumnsData(currentWorkPackages, addedColumns, groupBy);
    }

    columnsModal.deactivate();
  };
};
