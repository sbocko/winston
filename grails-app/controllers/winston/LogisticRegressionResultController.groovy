package winston

import grails.plugin.springsecurity.annotation.Secured
import sk.upjs.winston.Role

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured([Role.ROLE_USER])
class LogisticRegressionResultController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond LogisticRegressionResult.list(params), model:[logisticRegressionResultInstanceCount: LogisticRegressionResult.count()]
    }

    def show(LogisticRegressionResult logisticRegressionResultInstance) {
        respond logisticRegressionResultInstance
    }

    def create() {
        respond new LogisticRegressionResult(params)
    }

    @Transactional
    def save(LogisticRegressionResult logisticRegressionResultInstance) {
        if (logisticRegressionResultInstance == null) {
            notFound()
            return
        }

        if (logisticRegressionResultInstance.hasErrors()) {
            respond logisticRegressionResultInstance.errors, view:'create'
            return
        }

        logisticRegressionResultInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'logisticRegressionResult.label', default: 'LogisticRegressionResult'), logisticRegressionResultInstance.id])
                redirect logisticRegressionResultInstance
            }
            '*' { respond logisticRegressionResultInstance, [status: CREATED] }
        }
    }

    def edit(LogisticRegressionResult logisticRegressionResultInstance) {
        respond logisticRegressionResultInstance
    }

    @Transactional
    def update(LogisticRegressionResult logisticRegressionResultInstance) {
        if (logisticRegressionResultInstance == null) {
            notFound()
            return
        }

        if (logisticRegressionResultInstance.hasErrors()) {
            respond logisticRegressionResultInstance.errors, view:'edit'
            return
        }

        logisticRegressionResultInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'LogisticRegressionResult.label', default: 'LogisticRegressionResult'), logisticRegressionResultInstance.id])
                redirect logisticRegressionResultInstance
            }
            '*'{ respond logisticRegressionResultInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(LogisticRegressionResult logisticRegressionResultInstance) {

        if (logisticRegressionResultInstance == null) {
            notFound()
            return
        }

        logisticRegressionResultInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'LogisticRegressionResult.label', default: 'LogisticRegressionResult'), logisticRegressionResultInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'logisticRegressionResult.label', default: 'LogisticRegressionResult'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
