#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2015 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See doc/COPYRIGHT.rdoc for more details.
#++

require 'spec_helper'

describe ::API::V3::WorkPackages::Schema::WorkPackageSchemaRepresenter do
  let(:custom_field) { FactoryGirl.build(:custom_field) }
  let(:work_package) { FactoryGirl.build(:work_package) }
  let(:current_user) {
    FactoryGirl.build(:user, member_in_project: work_package.project)
  }
  let(:schema) {
    ::API::V3::WorkPackages::Schema::WorkPackageSchema.new(work_package: work_package)
  }
  let(:representer) { described_class.new(schema, current_user: current_user) }

  context 'generation' do
    subject(:generated) { representer.to_json }

    shared_context 'no allowed values' do
      before do
        allow(schema).to receive(:defines_assignable_values?).and_return(false)
      end
    end

    describe '_type' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { '_type' }
        let(:type) { 'MetaType' }
        let(:name) { I18n.t('api_v3.attributes._type') }
        let(:required) { true }
        let(:writable) { false }
      end
    end

    describe 'lock version' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'lockVersion' }
        let(:type) { 'Integer' }
        let(:name) { I18n.t('api_v3.attributes.lock_version') }
        let(:required) { true }
        let(:writable) { false }
      end
    end

    describe 'id' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'id' }
        let(:type) { 'Integer' }
        let(:name) { I18n.t('attributes.id') }
        let(:required) { true }
        let(:writable) { false }
      end
    end

    describe 'subject' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'subject' }
        let(:type) { 'String' }
        let(:name) { I18n.t('attributes.subject') }
        let(:required) { true }
        let(:writable) { true }
      end

      it 'indicates its minimum length' do
        is_expected.to be_json_eql(1.to_json).at_path('subject/minLength')
      end

      it 'indicates its maximum length' do
        is_expected.to be_json_eql(255.to_json).at_path('subject/maxLength')
      end
    end

    describe 'description' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'description' }
        let(:type) { 'Formattable' }
        let(:name) { I18n.t('attributes.description') }
        let(:required) { true }
        let(:writable) { true }
      end
    end

    describe 'startDate' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'startDate' }
        let(:type) { 'Date' }
        let(:name) { I18n.t('attributes.start_date') }
        let(:required) { false }
        let(:writable) { true }
      end
    end

    describe 'dueDate' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'dueDate' }
        let(:type) { 'Date' }
        let(:name) { I18n.t('attributes.due_date') }
        let(:required) { false }
        let(:writable) { true }
      end
    end

    describe 'estimatedTime' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'estimatedTime' }
        let(:type) { 'Duration' }
        let(:name) { I18n.t('attributes.estimated_time') }
        let(:required) { false }
        let(:writable) { false }
      end
    end

    describe 'spentTime' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'spentTime' }
        let(:type) { 'Duration' }
        let(:name) { I18n.t('activerecord.attributes.work_package.spent_time') }
        let(:required) { true }
        let(:writable) { false }
      end
    end

    describe 'percentageDone' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'percentageDone' }
        let(:type) { 'Integer' }
        let(:name) { I18n.t('activerecord.attributes.work_package.done_ratio') }
        let(:required) { true }
        let(:writable) { false }
      end
    end

    describe 'createdAt' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'createdAt' }
        let(:type) { 'DateTime' }
        let(:name) { I18n.t('attributes.created_at') }
        let(:required) { true }
        let(:writable) { false }
      end
    end

    describe 'updatedAt' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'updatedAt' }
        let(:type) { 'DateTime' }
        let(:name) { I18n.t('attributes.updated_at') }
        let(:required) { true }
        let(:writable) { false }
      end
    end

    describe 'author' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'author' }
        let(:type) { 'User' }
        let(:name) { I18n.t('attributes.author') }
        let(:required) { true }
        let(:writable) { false }
      end
    end

    describe 'project' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'project' }
        let(:type) { 'Project' }
        let(:name) { I18n.t('attributes.project') }
        let(:required) { true }
        let(:writable) { false }
      end
    end

    describe 'type' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'type' }
        let(:type) { 'Type' }
        let(:name) { I18n.t('activerecord.attributes.work_package.type') }
        let(:required) { true }
        let(:writable) { false }
      end
    end

    describe 'status' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'status' }
        let(:type) { 'Status' }
        let(:name) { I18n.t('attributes.status') }
        let(:required) { true }
        let(:writable) { true }
      end

      context 'w/o allowed statuses' do
        before { allow(work_package).to receive(:new_statuses_allowed_to).and_return([]) }

        it_behaves_like 'links to allowed values directly' do
          let(:path) { 'status' }
          let(:hrefs) { [] }
        end
      end

      context 'with allowed statuses' do
        let(:statuses) { FactoryGirl.build_list(:status, 3) }

        before { allow(work_package).to receive(:new_statuses_allowed_to).and_return(statuses) }

        it_behaves_like 'links to allowed values directly' do
          let(:path) { 'status' }
          let(:hrefs) { statuses.map { |status| "/api/v3/statuses/#{status.id}" } }
        end
      end

      context 'when allowed values are not defined' do
        include_context 'no allowed values'

        it_behaves_like 'does not link to allowed values' do
          let(:path) { 'status' }
        end
      end
    end

    describe 'versions' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'version' }
        let(:type) { 'Version' }
        let(:name) { I18n.t('activerecord.attributes.work_package.fixed_version') }
        let(:required) { false }
        let(:writable) { true }
      end

      context 'w/o allowed versions' do
        before { allow(work_package).to receive(:assignable_versions).and_return([]) }

        it_behaves_like 'links to allowed values directly' do
          let(:path) { 'version' }
          let(:hrefs) { [] }
        end
      end

      context 'with allowed versions' do
        let(:versions) { FactoryGirl.build_stubbed_list(:version, 3) }

        before { allow(work_package).to receive(:assignable_versions).and_return(versions) }

        it_behaves_like 'links to allowed values directly' do
          let(:path) { 'version' }
          let(:hrefs) { versions.map { |version| "/api/v3/versions/#{version.id}" } }
        end
      end

      context 'when allowed values are not defined' do
        include_context 'no allowed values'

        it_behaves_like 'does not link to allowed values' do
          let(:path) { 'version' }
        end
      end
    end

    describe 'priorities' do
      it_behaves_like 'has basic schema properties' do
        let(:path) { 'priority' }
        let(:type) { 'Priority' }
        let(:name) { I18n.t('activerecord.attributes.work_package.priority') }
        let(:required) { true }
        let(:writable) { true }
      end

      context 'w/o allowed priorities' do
        before { allow(work_package).to receive(:assignable_priorities).and_return([]) }

        it_behaves_like 'links to allowed values directly' do
          let(:path) { 'priority' }
          let(:hrefs) { [] }
        end
      end

      context 'with allowed priorities' do
        let(:priorities) { FactoryGirl.build_stubbed_list(:priority, 3) }

        before { allow(work_package).to receive(:assignable_priorities).and_return(priorities) }

        it_behaves_like 'links to allowed values directly' do
          let(:path) { 'priority' }
          let(:hrefs) { priorities.map { |priority| "/api/v3/priorities/#{priority.id}" } }
        end
      end

      context 'when allowed values are not defined' do
        include_context 'no allowed values'

        it_behaves_like 'does not link to allowed values' do
          let(:path) { 'priority' }
        end
      end
    end

    describe 'responsible and assignee' do
      let(:base_href) { "/api/v3/projects/#{work_package.project.id}" }

      describe 'assignee' do
        it_behaves_like 'has basic schema properties' do
          let(:path) { 'assignee' }
          let(:type) { 'User' }
          let(:name) { I18n.t('attributes.assigned_to') }
          let(:required) { false }
          let(:writable) { true }
        end

        it_behaves_like 'links to allowed values via collection link' do
          let(:path) { 'assignee' }
          let(:href) { "#{base_href}/available_assignees" }
        end

        context 'when allowed values are not defined' do
          include_context 'no allowed values'

          it_behaves_like 'does not link to allowed values' do
            let(:path) { 'assignee' }
          end
        end
      end

      describe 'responsible' do
        it_behaves_like 'has basic schema properties' do
          let(:path) { 'responsible' }
          let(:type) { 'User' }
          let(:name) { I18n.t('activerecord.attributes.work_package.responsible') }
          let(:required) { false }
          let(:writable) { true }
        end

        it_behaves_like 'links to allowed values via collection link' do
          let(:path) { 'responsible' }
          let(:href) { "#{base_href}/available_responsibles" }
        end

        context 'when allowed values are not defined' do
          include_context 'no allowed values'

          it_behaves_like 'does not link to allowed values' do
            let(:path) { 'responsible' }
          end
        end
      end
    end

    describe 'custom fields' do
      let(:injector) { double('injector') }

      before do
        allow(schema).to receive(:available_custom_fields).and_return([custom_field])
        allow(::API::V3::Utilities::CustomFieldInjector).to receive(:new).and_return(injector)
      end

      it 'uses a custom field injector' do
        expect(injector).to receive(:inject_schema).with(custom_field, wp_schema: schema)
        representer.to_json
      end
    end
  end
end
