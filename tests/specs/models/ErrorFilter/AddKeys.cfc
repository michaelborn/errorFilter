/**
 * My BDD Test
 */
component extends="coldbox.system.testing.BaseTestCase" accessors="true" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll() {
		super.beforeAll();
	}

	// executes after all suites+specs in the run() method
	function afterAll() {
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/


	function run() {
		describe(
			title  = "AddKeys should",
			labels = "automated",
			body   = function() {
				beforeEach( function() {
					fakeKey    = mockData( $type = "words:1", $num = 1 )[ 1 ];
					fakeList   = mockData( $type = "words:5", $num = 1 )[ 1 ].replace( " ", ",", "all" );
					fakeMaster = { "#fakeKey#" : fakeList };

					fakeError = {};
					fakeList.each( function( item, idx ) {
						fakeError[ item ]                       = mockData( $type = "words:1", $num = 1 )[ 1 ];
						fakeError[ item & randRange( 0, 100 ) ] = mockData( $type = "words:1", $num = 1 )[ 1 ];
					} );

					testobj = createmock( object = getInstance( "ErrorFilter@ErrorFilter" ) );
					testobj.settypeFields( fakeMaster );
				} );
				it( "If the submitted error is empty, return a struct with each key with 'NA'", function() {
					testme = testObj.addKeys( fakeKey, {} );
					expect( testme.keylist().listSort( "text" ) ).toBe( fakeList.listSort( "text" ) );
					testme
						.keyArray()
						.each( function( item ) {
							expect( testme[ item ] ).tobe( "NA" );
						} );
				} );
				it( "if the fakeError has values the result should have the matching values", function() {
					testme = testObj.addKeys( fakeKey, fakeError );
					expect( testme.keylist().listSort( "text" ) ).toBe( fakeList.listSort( "text" ) );
					testme
						.keyArray()
						.each( function( item ) {
							expect( testme[ item ] ).tobe( fakeError[ item ] );
						} );
				} );
				it( "any keys not in the 'fieldlist' should not be present", function() {
					testme = testObj.addKeys( fakeKey, fakeError );
					expect( testme.keylist().listSort( "text" ) ).toBe( fakeList.listSort( "text" ) );
					expect( testme.keylist().listlen() ).toBe( fakeList.listlen() );
					testme
						.keyArray()
						.each( function( item ) {
							expect( testme[ item ] ).tobe( fakeError[ item ] );
						} );
				} );
			}
		);
	}
	/*
	function fakeError() {
		return {
			"Extended_Info" : "",
			"Message"       : "Invalid object name 'factset.sym_v1.sym_coverage'.",
			"queryError"    : "UPDATE mars_231.dbo.mars_in_bench_holdings SET\r\n      security_name = proper_name\r\n      FROM mars_231.dbo.mars_in_bench_holdings b\r\n        JOIN factset.sym_v1.sym_coverage sc\r\n          ON b.security_id = sc.fsym_id\r\n      WHERE b.security_name = ''",
			"Sql"           : "UPDATE mars_231.dbo.mars_in_bench_holdings SET\r\n      security_name = proper_name\r\n      FROM mars_231.dbo.mars_in_bench_holdings b\r\n        JOIN factset.sym_v1.sym_coverage sc\r\n          ON b.security_id = sc.fsym_id\r\n      WHERE b.security_name = ''",
			"Detail"        : "",
			"SQLState"      : "S0002",
			"additional"    : {
				"SQL"             : "UPDATE mars_231.dbo.mars_in_bench_holdings SET\r\n      security_name = proper_name\r\n      FROM mars_231.dbo.mars_in_bench_holdings b\r\n        JOIN factset.sym_v1.sym_coverage sc\r\n          ON b.security_id = sc.fsym_id\r\n      WHERE b.security_name = ''",
				"DatabaseName"    : "Microsoft SQL Server",
				"DatabaseVersion" : "15.00.2095",
				"DriverName"      : "Microsoft JDBC Driver 7.2 for SQL Server",
				"DriverVersion"   : "7.2.2.0",
				"Datasource"      : "mars"
			},
			"TagContext"      : [],
			"ErrorCode"       : "0",
			"NativeErrorCode" : 208,
			"type"            : "database",
			"DataSource"      : "mars",
			"StackTrace"      : "lucee.runtime.exp.DatabaseException: Invalid object name 'factset.sym_v1.sym_coverage'.\r\n\tat com.microsoft.sqlserver.jdbc.SQLServerException.makeFromDatabaseError(SQLServerException.java:262)\r\n\tat com.microsoft.sqlserver.jdbc.SQLServerStatement.getNextResult(SQLServerStatement.java:1621)\r\n\tat com.microsoft.sqlserver.jdbc.SQLServerStatement.doExecuteStatement(SQLServerStatement.java:868)\r\n\tat com.microsoft.sqlserver.jdbc.SQLServerStatement$StmtExecCmd.doExecute(SQLServerStatement.java:768)\r\n\tat com.microsoft.sqlserver.jdbc.TDSCommand.execute(IOBuffer.java:7194)\r\n\tat com.microsoft.sqlserver.jdbc.SQLServerConnection.executeCommand(SQLServerConnection.java:2935)\r\n\tat com.microsoft.sqlserver.jdbc.SQLServerStatement.executeCommand(SQLServerStatement.java:248)\r\n\tat com.microsoft.sqlserver.jdbc.SQLServerStatement.executeStatement(SQLServerStatement.java:223)\r\n\tat com.microsoft.sqlserver.jdbc.SQLServerStatement.$fr$execute(SQLServerStatement.java:744)\r\n\tat com.microsoft.sqlserver.jdbc.SQLServerStatement.execute(SQLServerStatement.java)\r\n\tat lucee.runtime.type.util.QueryUtil.execute(QueryUtil.java:320)\r\n\tat lucee.runtime.type.QueryImpl.execute(QueryImpl.java:287)\r\n\tat lucee.runtime.type.QueryImpl.<init>(QueryImpl.java:235)\r\n\tat lucee.runtime.tag.Query.executeDatasoure(Query.java:1134)\r\n\tat lucee.runtime.tag.Query._doEndTag(Query.java:699)\r\n\tat lucee.runtime.tag.Query.doEndTag(Query.java:565)\r\n\tat lucee.runtime.functions.query.QueryExecute.call(QueryExecute.java:86)\r\n\tat lucee.runtime.functions.query.QueryExecute.call(QueryExecute.java:42)\r\n\tat models.tasks.benchmarks_cfc$cf$4.udfCall1(/models/tasks/Benchmarks.cfc:226)\r\n\tat models.tasks.benchmarks_cfc$cf$4.udfCall(/models/tasks/Benchmarks.cfc)\r\n\tat lucee.runtime.type.UDFImpl.implementation(UDFImpl.java:112)\r\n\tat lucee.runtime.type.UDFImpl._call(UDFImpl.java:350)\r\n\tat lucee.runtime.type.UDFImpl.call(UDFImpl.java:223)\r\n\tat lucee.runtime.type.scope.UndefinedImpl.call(UndefinedImpl.java:786)\r\n\tat lucee.runtime.util.VariableUtilImpl.callFunctionWithoutNamedValues(VariableUtilImpl.java:787)\r\n\tat lucee.runtime.PageContextImpl.getFunction(PageContextImpl.java:1762)\r\n\tat models.tasks.abstracttask_cfc$cf.udfCall1(/models/tasks/AbstractTask.cfc:69)\r\n\tat models.tasks.abstracttask_cfc$cf.udfCall(/models/tasks/AbstractTask.cfc)\r\n\tat lucee.runtime.type.UDFImpl.implementation(UDFImpl.java:112)\r\n\tat lucee.runtime.type.UDFImpl._call(UDFImpl.java:350)\r\n\tat lucee.runtime.type.UDFImpl.call(UDFImpl.java:223)\r\n\tat lucee.runtime.type.EnvUDF.call(EnvUDF.java:97)\r\n\tat lucee.runtime.ComponentScopeShadow.call(ComponentScopeShadow.java:313)\r\n\tat lucee.runtime.util.VariableUtilImpl.callFunctionWithoutNamedValues(VariableUtilImpl.java:787)\r\n\tat lucee.runtime.PageContextImpl.getFunction(PageContextImpl.java:1762)\r\n\tat coldbox.system.async.proxies.supplier_cfc$cf.udfCall(/coldbox/system/async/proxies/Supplier.cfc:35)\r\n\tat lucee.runtime.type.UDFImpl.implementation(UDFImpl.java:112)\r\n\tat lucee.runtime.type.UDFImpl._call(UDFImpl.java:350)\r\n\tat lucee.runtime.type.UDFImpl.call(UDFImpl.java:223)\r\n\tat lucee.runtime.ComponentImpl._call(ComponentImpl.java:697)\r\n\tat lucee.runtime.ComponentImpl._call(ComponentImpl.java:585)\r\n\tat lucee.runtime.ComponentImpl.call(ComponentImpl.java:1927)\r\n\tat lucee.runtime.java.JavaProxy.call(JavaProxy.java:64)\r\n\tat lucee.runtime.op.JavaProxyUtilImpl.call(JavaProxyUtilImpl.java:12)\r\n\tat V41d6f5ff26589bafd0e9056efd7641284276.get(Unknown Source)\r\n\tat java.util.concurrent.CompletableFuture$AsyncSupply.run(CompletableFuture.java:1604)\r\n\tat java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\r\n\tat java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\r\n\tat java.lang.Thread.run(Thread.java:748)\r\n",
			"where"           : "",
			"ExtendedInfo"    : ""
		};
	};
*/

}
