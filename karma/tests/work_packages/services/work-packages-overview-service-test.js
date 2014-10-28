//-- copyright
// OpenProject is a project management system.
// Copyright (C) 2012-2014 the OpenProject Foundation (OPF)
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

/*jshint expr: true*/

describe('WorkPackagesOverviewService', function() {

  var Service;

  beforeEach(module('openproject.services'));

  beforeEach(inject(function(_WorkPackagesOverviewService_){
    Service = _WorkPackagesOverviewService_;
  }));

  describe('getGroupAttributes', function() {
    var groupName = 'details';
    var attributes = ['status', 'percentageDone', 'date', 'priority', 'versionName', 'category'];

    it('has details', function() {
      var group = Service.getGroupAttributes(groupName);

      expect(group).not.to.be.null;
      expect(group).to.have.length(attributes.length);
      expect(group).to.include.members(attributes);
    });
  });

  describe('addAttributesToGroup', function() {
    var groupName = 'other';
    var attributes = ['me', 'myself', 'I'];

    it('adds attributes to group', function() {
      Service.addAttributesToGroup(groupName, attributes);
      var group = Service.getGroupAttributes(groupName);

      expect(group).not.to.be.null;
      expect(group).to.include.members(attributes);
    });
  });

  describe('addAttributeToGroup', function() {
    var groupName = 'people';
    var attribute = 'me';
    var position = 1;

    it('adds attribute to specific position in group', function() {
      Service.addAttributeToGroup(groupName, attribute, position);
      var group = Service.getGroupAttributes(groupName);

      expect(group).not.to.be.null;
      expect(group).to.have.length(3);
      expect(group).to.include.members(['assignee', 'responsible', attribute]);
      expect(group[1]).to.equal(attribute);
    });
  });

  describe('addGroup', function() {
    var groupName = 'myPluginGroup';

    describe('w/o position', function() {
      it('adds group to the end', function() {
        Service.addGroup(groupName);
        var groupedAttributs = Service.getGroupedWorkPackageOverviewAttributes();
        var lastElementIndex = groupedAttributs.length - 1;

        expect(groupedAttributs[lastElementIndex].groupName).to.equal(groupName);
        expect(groupedAttributs[lastElementIndex].attributes).to.be.empty;
      });
    });

    describe('with position', function() {
      var position = 2;

      it('adds group to the specified position', function() {
        Service.addGroup(groupName, position);
        var groupedAttributs = Service.getGroupedWorkPackageOverviewAttributes();

        expect(groupedAttributs.length).to.equal(5);
        expect(groupedAttributs[position].groupName).to.equal(groupName);
        expect(groupedAttributs[position].attributes).to.be.empty;
      });
    });
  });

  describe('removeAttributeFromGroup', function() {
    var groupName = 'estimateAndTime';
    var attribute = 'spentTime';

    it('removes attribute from group', function() {
      Service.removeAttributeFromGroup(groupName, attribute);
      var group = Service.getGroupAttributes(groupName);

      expect(group).not.to.be.null;
      expect(group).to.have.length(1);
      expect(group).to.include.members(['estimatedTime']);
    });
  });
});
