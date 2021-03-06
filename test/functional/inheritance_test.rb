# encoding: utf-8
# author: Dominik Richter
# author: Christoph Hartmann
require 'functional/helper'

describe 'example inheritance profile' do
  include FunctionalHelper
  let(:path) { File.join(examples_path, 'inheritance') }

  it 'check succeeds with --profiles-path' do
    out = inspec('check ' + path + ' --profiles-path ' + examples_path)
    out.stderr.must_equal ''
    out.stdout.must_match(/Valid.*true/)
    out.exit_status.must_equal 0
  end

  it 'check succeeds without --profiles-path using inspec.yml' do
    out = inspec('check ' + path)
    out.stderr.must_equal ''
    out.stdout.must_match(/Valid.*true/)
    out.exit_status.must_equal 0
  end

  it 'archive is successful with --profiles-path' do
    out = inspec('archive ' + path + ' --output ' + dst.path + ' --profiles-path ' + examples_path)
    out.stderr.must_equal ''
    out.stdout.must_include 'Generate archive '+dst.path
    out.stdout.must_include 'Finished archive generation.'
    out.exit_status.must_equal 0
    File.exist?(dst.path).must_equal true
  end

  it 'archive is successful without --profiles-path using inspec.yml' do
    out = inspec('archive ' + path + ' --output ' + dst.path)
    out.stderr.must_equal ''
    out.stdout.must_include 'Generate archive '+dst.path
    out.stdout.must_include 'Finished archive generation.'
    out.exit_status.must_equal 0
    File.exist?(dst.path).must_equal true
  end

  it 'read the profile json with --profiles-path' do
    out = inspec('json ' + path + ' --profiles-path '+examples_path)
    out.stderr.must_equal ''
    out.exit_status.must_equal 0
    s = out.stdout
    hm = JSON.load(s)
    hm['name'].must_equal 'inheritance'
    hm['controls'].length.must_equal 3
  end

  it 'read the profile json without --profiles-path using inspec.yml' do
    out = inspec('json ' + path)
    out.stderr.must_equal ''
    out.exit_status.must_equal 0
    s = out.stdout
    hm = JSON.load(s)
    hm['name'].must_equal 'inheritance'
    hm['controls'].length.must_equal 3
  end
end
