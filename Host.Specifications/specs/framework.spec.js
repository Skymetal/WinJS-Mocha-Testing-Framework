describe("Basic WinJS functionality", function () {
    it("should have WinJS", function () {
        expect(WinJS).to.exist
    });

    it("should fail a test", function () {
        expect(false).to.equal(true, "Intentional fail");
    });
});