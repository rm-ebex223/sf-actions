resource "snowflake_database" "test_db" {
  name     = "TEST_DB"
  provider = snowflake.deployuser_tf_deploy
}