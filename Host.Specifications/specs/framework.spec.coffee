describe "Basic WinJS functionality", ->

    it "should have WinJS", ->
        expect(WinJS).to.exist

    it "should be able to see the ProjectInterconnection Namespace from the linked project", ->
    	expect(ProjectInterconnection).to.exist

    # it.skip "should fail a test", ->
    #     expect(false).to.equal(true, "fail")
