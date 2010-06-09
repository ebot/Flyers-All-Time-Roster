Feature: View Player List

  Scenario: View Players By Name
    Given I am viewing "/by_name"
    Then I should see "By Player Name"
    And I should see "ACTON"
    And I should see "ZUBRUS"