Feature: Send video in future
  As registred user
  I want to be able upload my video
  In order to receive it in specified time

  Background:
    Given a regular user "Jack"
    And a banned user "Mariarty"

  Scenario: Jack upload a good video
    Given I am logged as "Jack"
    When I try to upload "Cat" video
    Then I should see "Video uploaded"
    And I should see "Cat" in videos list

  Scenario: Jack upload a several good videos
    Given I am logged as "Jack"
    When I try to upload "Cats, Dogs, Mices" videos
    Then I should see "Cats, Dogs, Mices" in videos list

  Scenario: Jack upload a bad video
    Given I am logged as "Jack"
    When I try to upload "Too big" video
    Then I should see "Too big file size" error
    When I try to upload "Unsupported" video
    Then I should see "Unsupported video format" error

  Scenario: Mariarty upload a good video
    Given I am logged as "Mariarty"
    When I try to upload "Cat" video
    Then I should see "You do not have ability to upload anymore. You have been banned." error

  Scenario: Jack waits his video from future
    Given "Jack" uploaded "Cat" video
    And this video must be delivered at specific time
    When this time is come
    Then "Jack" should recieve mail with "Cat" video
