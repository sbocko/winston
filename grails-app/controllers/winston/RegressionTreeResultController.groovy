package winston

import grails.plugin.springsecurity.annotation.Secured
import sk.upjs.winston.Role

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured([Role.ROLE_USER])
class RegressionTreeResultController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond RegressionTreeResult.list(params), model:[regressionTreeResultInstanceCount: RegressionTreeResult.count()]
    }

    def show(RegressionTreeResult regressionTreeResultInstance) {
        respond regressionTreeResultInstance
    }

    def create() {
        respond new RegressionTreeResult(params)
    }

    @Transactional
    def save(RegressionTreeResult regressionTreeResultInstance) {
        if (regressionTreeResultInstance == null) {
            notFound()
            return
        }

        if (regressionTreeResultInstance.hasErrors()) {
            respond regressionTreeResultInstance.errors, view:'create'
            return
        }

        regressionTreeResultInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'regressionTreeResult.label', default: 'RegressionTreeResult'), regressionTreeResultInstance.id])
                redirect regressionTreeResultInstance
            }
            '*' { respond regressionTreeResultInstance, [status: CREATED] }
        }
    }

    def edit(RegressionTreeResult regressionTreeResultInstance) {
        respond regressionTreeResultInstance
    }

    @Transactional
    def update(RegressionTreeResult regressionTreeResultInstance) {
        if (regressionTreeResultInstance == null) {
            notFound()
            return
        }

        if (regressionTreeResultInstance.hasErrors()) {
            respond regressionTreeResultInstance.errors, view:'edit'
            return
        }

        regressionTreeResultInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'RegressionTreeResult.label', default: 'RegressionTreeResult'), regressionTreeResultInstance.id])
                redirect regressionTreeResultInstance
            }
            '*'{ respond regressionTreeResultInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(RegressionTreeResult regressionTreeResultInstance) {

        if (regressionTreeResultInstance == null) {
            notFound()
            return
        }

        regressionTreeResultInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'RegressionTreeResult.label', default: 'RegressionTreeResult'), regressionTreeResultInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'regressionTreeResult.label', default: 'RegressionTreeResult'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
